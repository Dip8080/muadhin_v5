import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:muaddin/features/Home/presentation/screens/alerm_three.dart';
import 'package:muaddin/features/update/controller/update_controller.dart';

class UpdateScreen extends StatelessWidget {
  final UpdateController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Obx(() {
          if (!controller.isUpdateAvailable.value) {
            return const SizedBox(); // continue app
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.system_update, size: 80, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                "Update Available",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                "Latest version: ${controller.latestVersion.value}",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // ElevatedButton(
              //   onPressed: controller.openPlayStore,
              //   child: const Text("Update via Play Store"),
              // ),

              const SizedBox(height: 10),

              SizedBox(
                width: 40.w,
                child: ElevatedButton(
                  onPressed: controller.downloadApk,
                  child: const Text("Download APK"),
                ),
              ),

              const SizedBox(height: 20),

              if (!controller.isForceUpdate.value)
                TextButton(
                  onPressed: () {
                    Get.to(() => AlermThree());
                  },
                  child: const Text("Skip"),
                ),
            ],
          );
        }),
      ),
    );
  }
}