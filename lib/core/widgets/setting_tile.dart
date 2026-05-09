import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
// import 'package:muaddin/features/Home/controller/brightness_controller.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final BrightnessController brightnessController = Get.find();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(85, 79, 111, 143), // top
              Color.fromARGB(100, 62, 95, 130), // bottom
              Color.fromARGB(88, 42, 68, 99), // bottom
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),

          // glow border
          border: Border.all(
            color:    Color.fromARGB(255, 79, 111, 143),
            width: 1,
          ),

          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.white.withOpacity(.30),
          //     blurRadius: 12,
          //     spreadRadius: 1,
          //   )
          // ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Color.fromARGB(255, 167, 203, 255), size: 3.w),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.8.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.75),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Obx(
            //   () => Icon(
            //     !brightnessController.isExpanded.value
            //         ? Icons.keyboard_arrow_right
            //         : Icons.keyboard_arrow_down,
            //     color: Colors.white.withOpacity(.75),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
