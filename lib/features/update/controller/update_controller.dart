import 'package:get/get.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateController extends GetxController {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  var isUpdateAvailable = false.obs;
  var isForceUpdate = false.obs;
  var latestVersion = ''.obs;
  var apkUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
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
  }

  bool _isNewVersionAvailable(String current, String latest) {
    List<int> currentParts = current.split('.').map(int.parse).toList();
    List<int> latestParts = latest.split('.').map(int.parse).toList();

    for (int i = 0; i < latestParts.length; i++) {
      if (latestParts[i] > currentParts[i]) return true;
      if (latestParts[i] < currentParts[i]) return false;
    }
    return false;
  }

  /// Open Play Store
  Future<void> openPlayStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=your.package.name';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  /// Direct APK download
  Future<void> downloadApk() async {
    if (apkUrl.value.isNotEmpty) {
      await launchUrl(Uri.parse(apkUrl.value),
          mode: LaunchMode.externalApplication);
    }
  }
}