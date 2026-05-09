// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:muaddin/features/Home/controller/clock_controller.dart';
// import 'package:muaddin/features/Home/controller/prayer_time_controller.dart';
// import 'package:muaddin/features/Home/repository/model/prayer_time_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class PrayerTimeService {
//   final String city;
//   final String country;

//   PrayerTimeService({required this.city, required this.country});

//   Future<List<PrayerTimeModel>> fetchPrayerTimes() async {
//     final ClockController clockController = Get.find();
//     final PrayerTimeController prayerTimeController = Get.find();
//     final selectedCity = clockController.selectedTimeZone;
//     final cityTrimmed = selectedCity.split('/')[1].toLowerCase();
//     final url = 
//         'https://muslimsalat.com/dhaka.json?key=264b293a6c7424ee75fe1511839f4992';
//     // final url =
//     //     'https://muslimsalat.com/${cityTrimmed}.json?key=264b293a6c7424ee75fe1511839f4992';

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final prefs = await SharedPreferences.getInstance();
//       // await prefs.setString('prayerTimes', json.encode(data['items']));
//       // prayerTimeController.prayerTimes.assignAll(data['items']);
//       // print('this is all prayer time ${data['items']}');
//       final timings = data['data']['timings'] as Map<String, dynamic>;
//       // return PrayerTimeModel.fromJosn(timings);
//       return data['items'];
//     } else {
//       throw Exception('Failed to load prayer times');
//     }
//   }
// }
