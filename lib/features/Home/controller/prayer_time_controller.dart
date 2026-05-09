// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:just_audio/just_audio.dart';
// import 'package:muaddin/features/Home/controller/clock_controller.dart';
// import 'package:muaddin/features/Home/repository/model/prayer_time.dart';
// import 'package:shared_preferences/shared_preferences.dart';



// class PrayerTimeController extends GetxController {
//   // var prayerTimes = [].obs;
//   Rxn<PrayerTime> prayerTime = Rxn<PrayerTime>();
//   var prayerTimes = [].obs;
//   var isLoading = true.obs;
//   var error = ''.obs;
//   var countdownTime = "".obs;
//   var upComingPrayer = ''.obs;
//   var state = 'Amsterdam'.obs;
//   var adhanString = 'https://www.islamcan.com/audio/adhan/azan1.mp3'.obs;
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void onInit() {
//     super.onInit();  
//     fetchPrayerTimes();
//     print('this is prayer time list ${prayerTimes}');
//     // print('this is prayer time length ${prayerTimes.length}');
//   }

//   Timer? countdownTimer;

//   void updateAdhanString(String adhan) {
//     adhanString.value = adhan;
//   }

//   Future<void> fetchPrayerTimes() async { 
//     final String apiUrl =
//         "https://muslimsalat.com/${state.value}.json?key=264b293a6c7424ee75fe1511839f4992";
//     print('into fetch prayer time');
//     try {
//       isLoading(true);
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         print('success ${jsonDecode(response.body)}');
//         final data = json.decode(response.body);
//         final items = data['items'] ?? [];

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('prayerTimes', json.encode(data['items']));
//         prayerTimes.assignAll(items);
//         // print('this is prayer data ${prayerTimes.length}');
//         startCountdown();
//       } else {
//         Get.snackbar("Error", "Failed to load prayer times",
//             backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       // Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
//   // Future<void> fetchPrayerTimes() async {
//   //   final String apiUrl =
//   //        "https://api.aladhan.com/v1/timingsByCity/04-22-2025?city=leiden&country=GB&state=Netherlands&method=3&shafaq=general&tune=5%2C3%2C5%2C7%2C9%2C-1%2C0%2C8%2C-6&timezonestring=UTC&calendarMethod=UAQ%22%20";
//   //   print('into fetch prayer time');
//   //   try {
//   //     print('into try !!!!!!!!');
//   //     isLoading(true);
//   //     final response = await http.get(Uri.parse(apiUrl));
//   //      print('success ${jsonDecode(response.body)}');
//   //      print('successsssş');
//   //     if (response.statusCode == 200) {
//   //       // printInfo(printFunction: () {print('hellloooo');});
//   //       // print('success ${jsonDecode(response.body)}');
//   //       final data = json.decode(response.body);
//   //       print('${data['data']['timings']}');
//   //       final items = data['data']['timings'];
//   //       // final prefs = await SharedPreferences.getInstance();
//   //       // await prefs.setString('prayerTimes', json.encode(data['items']));
//   //       // prayerTimes.assignAll(items);
//   //       prayerTime.value = PrayerTime.fromJson(items);
//   //       print('dippppppppppppppppp');
//   //       // print('this is prayer data ${prayerTimes.length}');
//   //       startCountdown();
//   //     } else {
//   //       Get.snackbar("Error", "Failed to load prayer times",
//   //           backgroundColor: Colors.red);
//   //     }
//   //   } catch (e) {
//   //   } finally {
//   //     isLoading(false);
//   //   }
//   // }

//   void startCountdown() {
//     if (prayerTimes.isEmpty) return;
//     final ClockController clockController = Get.find();
//     final now = clockController.currentTime.value;
//     DateTime? nextPrayerTime;
//     for (var prayer in prayerTimes) {
//       String? timeString;
//       if (now.isBefore(_convertStringToTime(prayer['fajr']))) {
//         timeString = prayer['fajr'];
//         upComingPrayer.value = "fajr";
//       } else if (now.isBefore(_convertStringToTime(prayer['dhuhr']))) {
//         timeString = prayer['dhuhr'];
//         upComingPrayer.value = "dhuhr";
//       } else if (now.isBefore(_convertStringToTime(prayer['asr']))) {
//         timeString = prayer['asr'];
//         upComingPrayer.value = "asr";
//       } else if (now.isBefore(_convertStringToTime(prayer['maghrib']))) {
//         timeString = prayer['maghrib'];
//         upComingPrayer.value = 'maghrib';
//       } else if (now.isBefore(_convertStringToTime(prayer['isha']))) {
//         timeString = prayer['isha'];
//         upComingPrayer.value = 'isha';
//       }
     

//       if (timeString != null) {
//         nextPrayerTime = _convertStringToTime(timeString)
//             .subtract(const Duration(minutes: 0));
//         break;
//       }
//     }

//     if (nextPrayerTime != null) {
//       countdownTimer?.cancel();
//       countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         final now = DateTime.now();
//         final difference = nextPrayerTime!.difference(now);

//         if (difference.isNegative) {
//           timer.cancel();
//           _playAdhanAudio();
//           fetchPrayerTimes();
//         } else {
//           countdownTime.value = _formatDuration(difference);
//         }
//       });
//     }
//   }

//   void _playAdhanAudio() async {
//     try {
//       _audioPlayer.setUrl('${adhanString.value}');
//       _audioPlayer.play();
//     } catch (e) {
//       print('Error playing Adhan audio: ${e}');
//     }
//   }
// // need to update here !!!!
//   DateTime _convertStringToTime(String timeString) {
//     final now = DateTime.now();
//     final timeParts = timeString.split(':');
//     final hour = int.parse(timeParts[0]);
//     final minute = int.parse(timeParts[1].split(' ')[0]);
//     final period = timeParts[1].split(' ')[1].toLowerCase();
//     final finalHour = period == "pm" && hour != 12 ? hour + 12 : hour;
//     return DateTime(now.year, now.month, now.day, finalHour, minute);
//   }

//   String _formatDuration(Duration duration) {
//     final hours = duration.inHours.toString().padLeft(2, '0');
//     final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
//     final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
//     return "$hours:$minutes:$seconds";
//   }
// }
