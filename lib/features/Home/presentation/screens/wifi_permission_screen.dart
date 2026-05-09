import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';

class WifiPermissionScreen extends StatelessWidget {
  const WifiPermissionScreen({super.key});

  Future<void> _requestPermissions(BuildContext context) async {
    final status = await Permission.location.request(); // Required for Wi-Fi on Android 10+
    if (status.isGranted) {
      // Continue to home or next screen
      // Navigator.pushReplacementNamed(context, '/home');
      // Get.to(()=> AlermTwo());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wi-Fi permission is required to continue')),
      );
    }
  }

//   Future<void> _requestPermissions(BuildContext context) async {
//   // Check current connectivity
//   final connectivityResult = await Connectivity().checkConnectivity();

//   if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
//     // Internet is available, continue
//     Get.to(() => AlermTwo());
//   } else {
//     // No internet or Wi-Fi
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Internet Required"),
//         content: Text("Please enable Wi-Fi or mobile data to continue."),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               AppSettings.openAppSettingsPanel(AppSettingsPanelType.wifi);
//             },
//             child: Text("Open Wi-Fi Settings"),
//           ),
//         ],
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _requestPermissions(context),
          child: Text("Allow Wi-Fi Access"),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:muaddin/features/Home/presentation/screens/alerm_two.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:app_settings/app_settings.dart';

// class WifiPermissionScreen extends StatefulWidget {
//   const WifiPermissionScreen({super.key});

//   @override
//   State<WifiPermissionScreen> createState() => _WifiPermissionScreenState();
// }

// class _WifiPermissionScreenState extends State<WifiPermissionScreen> {
//   bool isWifiConnected = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkWifiStatus();
//   }

//   Future<void> _checkWifiStatus() async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     final locationStatus = await Permission.location.status;

//     setState(() {
//       isWifiConnected = connectivityResult == ConnectivityResult.wifi;
//     });

//     if (!locationStatus.isGranted) {
//       await Permission.location.request();
//     }

//     if (isWifiConnected) {
//       // Navigate to your home screen if Wi-Fi is ON
//       Get.to(() => AlermTwo());
//     }
//   }

//   void _openWifiSettings() {
//     AppSettings.openAppSettings();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: isWifiConnected
//             ? CircularProgressIndicator()
//             : Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.wifi_off, size: 64, color: Colors.grey),
//                   SizedBox(height: 16),
//                   Text('Wi-Fi is turned off. Please enable it to continue.'),
//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: _openWifiSettings,
//                     child: Text('Open Wi-Fi Settings'),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
