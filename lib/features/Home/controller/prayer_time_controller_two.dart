// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:just_audio/just_audio.dart';

// class PrayerTimeControllerTwo extends GetxController {
//   final RxList<String> states = <String>[
//     'Gouda',
//     'Amsterdam',
//     'Rotterdam',
//     'The Hague',
//     'Utrecht',
//     'Almere',
//     'Groningen',
//     'Eindhoven',
//     'Breda',
//     'Nijmegen',
//     'Zaanstad',
//     'Arnhem',
//     'Haarlem',
//     'Amersfoort',
//     'Apeldoorn',
//     'Leiden',
//     'Zwolle',
//     'Zoetermeer',
//     'Maastricht',
//     'Dordrecht',
//     'Leeuwarden',
//     'Alkmaar',
//     'Emmen',
//     'Hilversum',
//     'Helmond',
//     'Schiedam',
//     'Lelystad',
//     'Hoorn',
//     'Vlaardingen',
//     'Almelo',
//     'Assen',
//     'Delft',
//     'Deventer',
//     'Middelburg',
//     'Harderwijk',
//     'Zutphen',
//     'Medemblik',
//     'Wageningen',
//     'Beverwijk',
//     'Culemborg',
//     'Maassluis',
//     'Best',
//     'Elburg',
//     'Veere',
//     'Enkhuizen',
//     'Laren',
//     'Sloten'
//   ].obs;
//   final AudioPlayer _player = AudioPlayer();
//   String? _lastPlayedPrayer;
//   final RxString state = 'Amsterdam'.obs;

//   final RxMap<String, DateTime> prayerTimes = <String, DateTime>{}.obs;
//   final RxMap<String, int> adjustments = {
//     'fajr': 0,
//     // 'shurooq': 0,
//     'dhuhr': 0,
//     'asr': 0,
//     'maghrib': 0,
//     'isha': 0,
//   }.obs;

//   RxString nextPrayer = ''.obs;
//   Rx<Duration> timeRemaining = Duration.zero.obs;
//   final DateFormat _timeFormat = DateFormat("h:mm a");
// // dddd
//   Future<void> fetchPrayerTimes() async {
//     final url =
//          "https://muslimsalat.com/${state.value}.json?key=264b293a6c7424ee75fe1511839f4992";
//       //  final String url =
//         //  "https://api.aladhan.com/v1/timingsByCity/04-22-2025?city=leiden&country=GB&state=Netherlands&method=3&shafaq=general&tune=5%2C3%2C5%2C7%2C9%2C-1%2C0%2C8%2C-6&timezonestring=UTC&calendarMethod=UAQ%22%20";
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         final rawDate = data['items'][0]['date_for']; // e.g., '2025-5-10'
//         final dateParts = rawDate.split('-');
//         final year = int.parse(dateParts[0]);
//         final month = int.parse(dateParts[1].padLeft(2, '0'));
//         final day = int.parse(dateParts[2].padLeft(2, '0'));
//         final parsedDate = DateTime(year, month, day);

//         final items = data['items'][0];
//         final times = {
//           'fajr': items['fajr'],
//           // 'fajr': items['shurooq'],
//           // 'shurooq': items['shurooq'],
//           'dhuhr': items['dhuhr'],
//           'asr': items['asr'],
//           'maghrib': items['maghrib'],
//           'isha': items['isha'],
//         };

//         print("Loaded times: $times");
//         loadPrayerTimes(times, parsedDate);
//         startTimer();
//       } else {
//         throw Exception('Failed to fetch prayer times');
//       }
//     } catch (e) {
//       print("Error fetching prayer times: $e");
//     }
//   }

//   Future<void> fetchPrayertimeTwo() async {
//     final String apiUrl = '';
//     try{
//       final response = await http.get(Uri.parse(apiUrl));
//       if(response.statusCode == 200) {
        
//       }
//     }
//     catch(e){

//     } 
//   }

//   // hello darkness my old friend


//   void loadPrayerTimes(Map<String, dynamic> rawTimes, DateTime date) {
//     prayerTimes.clear();
//     rawTimes.forEach((key, value) {
//       try {
//         final timeStr =
//             value.toString().toUpperCase();
//         final fullDateTime = _timeFormat.parse(timeStr);
//         prayerTimes[key] = DateTime(
//           date.year,
//           date.month,
//           date.day,
//           fullDateTime.hour,
//           fullDateTime.minute,
//         );
//       } catch (e) {
//         print("Error parsing $key: $e");
//       }
//     });
//     updateNextPrayer();
//   }

//   void adjustPrayerTime(String key, int minutes) {
//     adjustments[key] = minutes;
//     updateNextPrayer();
//   }

//   DateTime getAdjustedTime(String key) {
//     final original = prayerTimes[key];
//     final offset = adjustments[key] ?? 0;
//     return original?.add(Duration(minutes: offset)) ?? DateTime.now();
//   }

//   void updateNextPrayer() {
//     final now = DateTime.now();
//     final sorted = prayerTimes.keys.toList()
//       ..sort((a, b) => getAdjustedTime(a).compareTo(getAdjustedTime(b)));

//     for (var prayer in sorted) {
//       final adjustedTime = getAdjustedTime(prayer);
//       if (adjustedTime.isAfter(now)) {
//         nextPrayer.value = prayer;
//         timeRemaining.value = adjustedTime.difference(now);
//         return;
//       }
//     }

//     nextPrayer.value = 'fajr';
//     timeRemaining.value =
//         getAdjustedTime('fajr').add(Duration(days: 1)).difference(now);
//   }

//   void startTimer() {
//     ever(prayerTimes, (_) => updateNextPrayer());
//     ever(adjustments, (_) => updateNextPrayer());

//     Future.doWhile(() async {
//       await Future.delayed(Duration(seconds: 1));

//       final now = DateTime.now();
//       final adjustedTime = getAdjustedTime(nextPrayer.value);
//       final diff = adjustedTime.difference(now);

//       timeRemaining.value = diff;

//       // if (diff.inSeconds <= 0 && _lastPlayedPrayer != nextPrayer.value) {
//          if (diff.inSeconds <= 0) {
//         _playAdhan();
//         _lastPlayedPrayer = nextPrayer.value;
//       }

//       return true;
//     });
//   }

//   Future<void> _playAdhan() async {
//     try {
//       await _player.setUrl('https://www.islamcan.com/audio/adhan/azan1.mp3');
//       await _player.play();
//     } catch (e) {
//       print("Error playing Adhan: $e");
//     }
//   }

//   @override
//   void onClose() {
//     _player.dispose();
//     super.onClose();
//   }
// }
