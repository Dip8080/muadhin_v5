// import 'package:flutter/material.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:muaddin/features/Home/controller/prayer_time_controller.dart';

// class CirclePrayerTime extends StatelessWidget {
//   const CirclePrayerTime({
//     super.key,
//     required this.prayerName,
//     required this.prayerTime,
//   });

//   final String prayerName;
//   final String prayerTime;

//   String convertTo24HourFormat(String time) {
//     try {
//       // Ensure consistent format (trim spaces, uppercase AM/PM)
//       String cleanedTime = time.trim().toUpperCase();

//       // Parse 12-hour format and convert to 24-hour format
//       DateTime dateTime = DateFormat("h:mm a").parse(cleanedTime);
//       return DateFormat("HH:mm").format(dateTime);
//     } catch (e) {
//       return "Invalid time format"; // Handle error gracefully
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final PrayerTimeController prayerTimeController = Get.find();
//     final String timeLeft = prayerTimeController.countdownTime.value ;
//     return Obx(() => Container(
//       margin: EdgeInsets.symmetric(horizontal: .2.w),
//       decoration: BoxDecoration(
//         border: Border.all(color: prayerTimeController.upComingPrayer.value.toLowerCase() != prayerName.toLowerCase() ? Colors.white : Colors.red, width: 1),
//         shape: BoxShape.circle,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             prayerName,
//             style: TextStyle(
//               fontSize: 2.3.w,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 5),
//           Text(
//             convertTo24HourFormat(prayerTime),
//             style: TextStyle(
//               fontSize: 1.7.w,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     ));
//   }
// }

// --------------------------------
// import 'package:flutter/material.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:muaddin/features/Home/controller/prayer_time_controller.dart';

// class CirclePrayerTime extends StatelessWidget {
//   const CirclePrayerTime({
//     super.key,
//     required this.prayerName,
//     required this.prayerTime,
//   });

//   final String prayerName;
//   final String prayerTime;

//   String convertTo24HourFormat(String time) {
//     try {
//       String cleanedTime = time.trim().toUpperCase();
//       DateTime dateTime = DateFormat("h:mm a").parse(cleanedTime);
//       return DateFormat("HH:mm").format(dateTime);
//     } catch (e) {
//       return "Invalid time format";
//     }
//   }

//   int parseTimeLeft(String timeLeft) {
//     List<String> parts = timeLeft.split(':');
//     if (parts.length == 2) {
//       int hours = int.tryParse(parts[0]) ?? 0;
//       int minutes = int.tryParse(parts[1]) ?? 0;
//       return (hours * 60 + minutes) * 60; // Convert to seconds
//     }
//     return 0;
//   }

//   Color getColorFromTimeLeft(int secondsLeft) {
//     if (secondsLeft <= 600) return Colors.green; // ≤ 10 min → Full Red
//     if (secondsLeft <= 1800) {
//       // 10 min - 30 min → Red to Orange
//       double ratio = (secondsLeft - 600) / (1800 - 600);
//       return Color.lerp(Colors.white, Colors.orange, ratio) ?? Colors.orange;
//     }
//     if (secondsLeft <= 3600) {
//       // 30 min - 1 hour → Orange to Yellow
//       double ratio = (secondsLeft - 1800) / (3600 - 1800);
//       return Color.lerp(Colors.orange, Colors.yellow, ratio) ?? Colors.yellow;
//     }
//     if (secondsLeft <= 7200) {
//       // 1 hour - 2 hours → Yellow to White
//       double ratio = (secondsLeft - 3600) / (7200 - 3600);
//       return Color.lerp(Colors.yellow, Colors.white, ratio) ?? Colors.white;
//     }
//     return Colors.white; // More than 2 hours → Full White
//   }

//   @override
//   Widget build(BuildContext context) {
//     final PrayerTimeController prayerTimeController = Get.find();
//     final String timeLeft = prayerTimeController.countdownTime.value ;

//     return Obx(() {
//       int secondsLeft = parseTimeLeft(prayerTimeController.countdownTime.value);
//       return AnimatedContainer(
//         duration: Duration(seconds: 1),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color:  prayerTimeController.upComingPrayer.value.toLowerCase() != prayerName.toLowerCase() ? Colors.white : getColorFromTimeLeft(secondsLeft),
//             width: 2,
//           ),
//           shape: BoxShape.circle,
//         ),
//         margin: EdgeInsets.symmetric(horizontal: .2.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               prayerName,
//               style: TextStyle(
//                 fontSize: 2.3.w,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 5),
//             Text(
//               convertTo24HourFormat(prayerTime),
//               style: TextStyle(
//                 fontSize: 1.7.w,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// -------------------new one


import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muaddin/features/Home/controller/prayer_time_controller.dart';
import 'package:muaddin/features/Home/controller/prayer_time_controller_four.dart';
import 'dart:math';

class CirclePrayerTime extends StatelessWidget {
  CirclePrayerTime({
    super.key,
    required this.prayerName,
    required this.prayerTime,
  });

  final String prayerName;
  final String prayerTime;

  String convertTo24HourFormat(String time) {
    try {
      String cleanedTime = time.trim().toUpperCase();
      DateTime dateTime = DateFormat("h:mm a").parse(cleanedTime);
      return DateFormat("HH:mm").format(dateTime);
    } catch (e) {
      return "Invalid time format";
    }
  }

  int parseTimeLeft(String timeLeft) {
    List<String> parts = timeLeft.split(':');
    if (parts.length == 2) {
      int hours = int.tryParse(parts[0]) ?? 0;
      int minutes = int.tryParse(parts[1]) ?? 0;
      return (hours * 60 + minutes) * 60; // Convert to total seconds
    }
    return 0;
  }


  static const double totalDuration = .3 * 60 * 60; 
  double timeLeft = totalDuration;
  @override
  Widget build(BuildContext context) {
    // final PrayerTimeController prayerTimeController = Get.find();
    // final PrayerTimeControllerThree prayerTimeControllerThree = Get.find();
    final PrayerTimeControllerFour prayerTimeControllerFour = Get.find();

    return Obx(() {
      // int secondsLeft = parseTimeLeft(prayerTimeController.countdownTime.value);
      int totalTime = 7200; 
      // double progress =
      //     (secondsLeft / totalTime).clamp(0.0, 1.0); 

      return GestureDetector(
        onTap: () {
          // print('this is prgress ${progress}');
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: prayerTimeControllerFour.nextPrayer.value.toLowerCase() != prayerName.toLowerCase() ? Colors.white : Colors.white.withOpacity(.3), width: 2),
          ),
          margin: EdgeInsets.symmetric(horizontal: .2.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // SizedBox(
              //   width: 15.w,
              //   height: 15.w,
              //   child: CustomPaint(
              //     painter: CircleBorderPainter(progress),
              //   ),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    prayerName.tr,
                    style: TextStyle(
                      fontSize: 2.3.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    // convertTo24HourFormat(prayerTime),
                      '${prayerTime.toString()}',
                        style: TextStyle(
                      fontSize: 1.7.w,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CircleBorderPainter extends CustomPainter {
  final double progress;

  CircleBorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    print('this is progress here ${progress}');
    Paint paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Rect rect = Rect.fromLTWH(2, 2, size.width - 4, size.height - 4);
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi;

    paint.shader = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + 2 * pi,
      colors: [Colors.red, const Color.fromARGB(255, 244, 241, 241)],
      stops: [progress, progress],
    ).createShader(rect);

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CircleBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
