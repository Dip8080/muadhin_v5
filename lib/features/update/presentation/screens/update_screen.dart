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
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F172A), // Slate 900
              Color(0xFF020617), // Slate 950
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Container(
                  width: 90.w,
                  // height: 90.h,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Obx(() {
                    final isDownloading = controller.isDownloading.value;
                    final progress = controller.downloadProgress.value;
                    final status = controller.downloadStatus.value;
                    final isForce = controller.isForceUpdate.value;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center ,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Premium Glow Icon
                        Container(
                          padding: EdgeInsets.all(2.w),
                          // margin: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8ED6D8).withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF8ED6D8).withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            isDownloading ? Icons.cloud_download : Icons.system_update_rounded,
                            size: 6.w,
                            color: const Color(0xFF8ED6D8),
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // Title
                        Text(
                          isDownloading ? "Updating System" : "New Update Available",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 2.w,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: .5.h),

                        // Version details
                        Text(
                          "Latest Version: ${controller.latestVersion.value}",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 1.8.w,
                          ),
                        ),
                        SizedBox(height: 1.h),

                        // Main Content Card (Details / Progress)
                        if (!isDownloading) ...[
                          // Changelog placeholder or message
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "What's New:",
                                  style: TextStyle(
                                    color: const Color(0xFFE6EFA6),
                                    fontSize: 2.w,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  controller.whatsNew.value.isNotEmpty
                                      ? controller.whatsNew.value.replaceAll('\\n', '\n')
                                      : "• Performance optimizations & stability fixes.\n• Seamless background APK update handling.\n• Audio playback improvements.",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 1.8.w,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),

                          // Download Button
                          GestureDetector(
                            onTap: controller.startInAppUpdate,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 2.2.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE6EFA6),
                                    Color(0xFF8ED6D8),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF8ED6D8).withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Update Now",
                                  style: TextStyle(
                                    fontSize: 2.w,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          // Live Progress View
                          Column(
                            children: [
                              // Progress bar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: 2.h,
                                  width: double.infinity,
                                  color: Colors.white.withOpacity(0.08),
                                  child: Stack(
                                    children: [
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          return AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            width: constraints.maxWidth * progress,
                                            height: double.infinity,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFE6EFA6),
                                                  Color(0xFF8ED6D8),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),

                              // Status text
                              Text(
                                status,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 2.w,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              
                              Text(
                                "Please do not close or exit the application.",
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 2.w,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                        ],

                        // Skip / Secondary actions
                        if (!isDownloading && !isForce) ...[
                          SizedBox(height: 1.h),
                          TextButton(
                            onPressed: () {
                              Get.offAll(() => const AlermThree());
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white38,
                            ),
                            child: Text(
                              "Remind Me Later",
                              style: TextStyle(fontSize: 1.7.w),
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}