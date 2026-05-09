// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tzData;

// class ClockController extends GetxController {
//   var currentTime = DateTime.now().obs;
//   // var selectedTimeZone = 'Asia/Dhaka'.obs;
//   var selectedTimeZone = 'Europe/Amsterdam'.obs;
//   // var selectedTimeZone = 'GMT+1'.obs;
//   var timezoneLocations = <String>[].obs;
//   var isToogleClicked = false.obs;
//   var currentTimeInSelectedTimezone = ''.obs;
//   var selectedLanguage = 'nl'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     tzData.initializeTimeZones();
//     _fetchAllTimeZones();
//     _startClock();
//   }

//   void _fetchAllTimeZones() {
//     timezoneLocations.assignAll(tz.timeZoneDatabase.locations.keys.toList());
//     update();
//   }

//   void _startClock() {
//     ever(currentTime, (_) => update());
//     Timer.periodic(Duration(seconds: 60), (_) {
//       if (selectedTimeZone.value == 'Europe/Amsterdam') {
//         print('we are here.......');
//         currentTime.value = DateTime.now().toUtc();
//       } else {
//         print('selectedTimeZone.value: ${selectedTimeZone.value}');
//         final location = tz.getLocation(selectedTimeZone.value);
//         currentTime.value = tz.TZDateTime.now(location);
//         currentTime.value = DateTime.now().toUtc();
//       }
//     });
//   }

//   void updateTimeManually(DateTime newTime) {
//     currentTime.value = newTime;
//     update();
//   }

//   void changeTimeZone(String timeZone) {
//     selectedTimeZone.value = timeZone;
//     final location = tz.getLocation(timeZone);
//     currentTime.value = tz.TZDateTime.now(location);
//     debugPrint('==============>>>>$selectedTimeZone');
//     update();
//   }

//   String getTimeInTimeZone(String timeZone, DateTime dateTime) {
//     final location = tz.getLocation(timeZone);
//     final tzTime = tz.TZDateTime.from(dateTime, location);
//     return tzTime.toString();
//   }

//   String getCurrentTimeInSelectedTimeZone() {
//     final location = tz.getLocation(selectedTimeZone.value);
//     final tzTime = tz.TZDateTime.now(location);
//     final formatter = DateFormat('HH:mm');
//     return formatter.format(tzTime);
//   }

//   String getCurrentDateInSelectedTimeZone() {
//     final location = tz.getLocation(selectedTimeZone.value);
//     final tzTime = tz.TZDateTime.now(location);
//     final formatter = DateFormat('MMMM d, yyyy', selectedLanguage.value);
//     final formatted = formatter.format(tzTime);
//     //  return formatted[0].toUpperCase() + formatted.substring(1);
//     return formatter.format(tzTime);
//   }
//   String getCurrentDaySelectedTimeZone() {
//     final location = tz.getLocation(selectedTimeZone.value);
//     final tzTime = tz.TZDateTime.now(location);
//     final formatter = DateFormat('EEEE', selectedLanguage.value);
//     return formatter.format(tzTime);
//   }

//   bool isValidTimeZone(String timeZone) {
//     return tz.timeZoneDatabase.locations.containsKey(timeZone);
//   }
// }
