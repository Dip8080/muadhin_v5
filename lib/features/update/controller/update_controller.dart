import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateController extends GetxController {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  var isUpdateAvailable = false.obs;
  var isForceUpdate = false.obs;
  var latestVersion = ''.obs;
  var apkUrl = ''.obs;

  // New states for in-app update progress
  var isDownloading = false.obs;
  var downloadProgress = 0.0.obs;
  var downloadStatus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );

      await _remoteConfig.fetchAndActivate();

      latestVersion.value = _remoteConfig.getString('latest_version');
      isForceUpdate.value = _remoteConfig.getBool('force_update');
      apkUrl.value = _remoteConfig.getString('apk_url');

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      isUpdateAvailable.value =
          _isNewVersionAvailable(currentVersion, latestVersion.value);
    } catch (e) {
      print('Update check failed: $e');
      // Set to sentinel to prevent infinite loading screens on check failures
      latestVersion.value = 'unknown'; 
    }
  }

  bool _isNewVersionAvailable(String current, String latest) {
    try {
      // Split version by '+' to separate version name and build number
      final currentClean = current.split('+')[0];
      final latestClean = latest.split('+')[0];

      List<int> currentParts = currentClean.split('.').map((e) => int.tryParse(e) ?? 0).toList();
      List<int> latestParts = latestClean.split('.').map((e) => int.tryParse(e) ?? 0).toList();

      int maxLength = currentParts.length > latestParts.length ? currentParts.length : latestParts.length;
      for (int i = 0; i < maxLength; i++) {
        int currentVal = i < currentParts.length ? currentParts[i] : 0;
        int latestVal = i < latestParts.length ? latestParts[i] : 0;

        if (latestVal > currentVal) return true;
        if (latestVal < currentVal) return false;
      }

      // If version names are identical, compare build numbers if present
      final currentBuildStr = current.contains('+') ? current.split('+')[1] : '0';
      final latestBuildStr = latest.contains('+') ? latest.split('+')[1] : '0';
      final currentBuild = int.tryParse(currentBuildStr) ?? 0;
      final latestBuild = int.tryParse(latestBuildStr) ?? 0;

      return latestBuild > currentBuild;
    } catch (e) {
      // Fallback in case of parse error
      return current != latest;
    }
  }

  /// Open Play Store
  Future<void> openPlayStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=your.package.name';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  /// Direct APK download (Legacy)
  Future<void> downloadApkLegacy() async {
    if (apkUrl.value.isNotEmpty) {
      await launchUrl(Uri.parse(apkUrl.value),
          mode: LaunchMode.externalApplication);
    }
  }

  /// In-App Update: download APK in background and trigger installation
  Future<void> startInAppUpdate() async {
    if (apkUrl.value.isEmpty) {
      downloadStatus.value = "Error: Invalid update URL.";
      return;
    }

    isDownloading.value = true;
    downloadProgress.value = 0.0;
    downloadStatus.value = "Preparing update...";

    try {
      // 1. Request REQUEST_INSTALL_PACKAGES permission first
      // In Android 8+, this requires checking settings
      var status = await Permission.requestInstallPackages.status;
      if (!status.isGranted) {
        downloadStatus.value = "Requesting installation permission...";
        status = await Permission.requestInstallPackages.request();
        if (!status.isGranted) {
          downloadStatus.value = "Installation permission denied. Redirecting to external browser...";
          await Future.delayed(const Duration(seconds: 2));
          await downloadApkLegacy();
          isDownloading.value = false;
          return;
        }
      }

      // 2. Download APK in background with progress tracking
      downloadStatus.value = "Starting download...";
      final tempDir = await getTemporaryDirectory();
      final apkPath = "${tempDir.path}/update.apk";
      
      // Clean up existing download if any
      final existingFile = File(apkPath);
      if (await existingFile.exists()) {
        await existingFile.delete();
      }

      final client = http.Client();
      final request = http.Request('GET', Uri.parse(apkUrl.value));
      final response = await client.send(request);

      if (response.statusCode != 200) {
        throw Exception("Server returned HTTP ${response.statusCode}");
      }

      final contentLength = response.contentLength ?? 0;
      int downloadedBytes = 0;
      final fileSink = existingFile.openWrite();

      await response.stream.listen(
        (chunk) {
          fileSink.add(chunk);
          downloadedBytes += chunk.length;
          if (contentLength > 0) {
            downloadProgress.value = downloadedBytes / contentLength;
            downloadStatus.value = "Downloading: ${(downloadProgress.value * 100).toStringAsFixed(1)}%";
          } else {
            downloadStatus.value = "Downloading... (${(downloadedBytes / (1024 * 1024)).toStringAsFixed(2)} MB)";
          }
        },
        onDone: () async {
          await fileSink.flush();
          await fileSink.close();
          client.close();

          downloadStatus.value = "Download completed! Launching installer...";
          downloadProgress.value = 1.0;
          await Future.delayed(const Duration(milliseconds: 500));

          // 3. Trigger APK Installation
          await _installApk(apkPath);
        },
        onError: (err) async {
          await fileSink.close();
          client.close();
          throw err;
        },
        cancelOnError: true,
      );

    } catch (e) {
      isDownloading.value = false;
      downloadStatus.value = "Update failed: $e";
      print("In-app update error: $e");
    }
  }

  /// Launch the installer for the downloaded APK file
  Future<void> _installApk(String filePath) async {
    try {
      final result = await OpenFilex.open(filePath);
      if (result.type != ResultType.done) {
        throw Exception(result.message);
      }
      downloadStatus.value = "Update installer opened successfully.";
      isDownloading.value = false;
    } catch (e) {
      downloadStatus.value = "Installation trigger failed: $e";
      isDownloading.value = false;
      print("OpenFilex execution error: $e");
      
      // Fallback: request user to open external browser
      await downloadApkLegacy();
    }
  }
}