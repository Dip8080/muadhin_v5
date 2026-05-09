// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:muaddin/features/Home/controller/prayer_time_controller.dart';

// class PrayerTimeScreenDemoDemoDemo extends StatelessWidget {
//   const PrayerTimeScreenDemoDemoDemo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final PrayerTimeController controller = Get.find();
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back)),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: Colors.red,
//             ),
//           );
//         }
//         final pt = controller.prayerTime.value;
//         if (pt == null) {
//           return Center(
//             child: Text('No Data'),
//           );
//         }
//         final Map<String, String> times = {
//           "Fajr": pt.fajr,
//           "Sunrise": pt.sunrise,
//           "Dhuhr": pt.dhuhr,
//           "Asr": pt.asr,
//           "Maghrib": pt.maghrib,
//           "Isha": pt.isha
//         };
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: GridView.count(
//             crossAxisCount: 6,
//             crossAxisSpacing: 2,
//             mainAxisSpacing: 2,
//             children: times.entries.map((entry) { 
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(entry.key,
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 8),
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.blueAccent, width: 2),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       entry.value,
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blueAccent,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ],
//               );
//             }).toList(),
//           ),
//         );
//       }),
//     );
//   }
// }
/// lib/screens/prayer_time_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:muaddin/features/Home/controller/prayer_time_controller_two.dart';

// class PrayerTimeScreenDemo extends StatelessWidget {
//   final PrayerTimeControllerTwo controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchPrayerTimes();
//     });
// // fjeijf
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() => Text("Prayer Times - ${controller.state.value}", style: TextStyle(fontSize: 2.w),)),
//         actions: [
//           Obx(() => DropdownButton<String>(
//                 value: controller.state.value,
//                 items: controller.states
//                     .map((s) => DropdownMenuItem(value: s, child: Text(s,style: TextStyle(fontSize: 2.w),)))
//                     .toList(),
//                 onChanged: (newState) {
//                   if (newState != null) {
//                     controller.state.value = newState;
//                     controller.fetchPrayerTimes();
//                   }
//                 },
//               )),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.prayerTimes.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return ListView( 
//           padding: EdgeInsets.all(16),
//           children: [
//             Text("Next Prayer: ${controller.nextPrayer.value.toUpperCase()}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
//             SizedBox(height: 4),
//             Text("Time Remaining: ${controller.timeRemaining.value.inHours}h "
//                 "${controller.timeRemaining.value.inMinutes % 60}m "
//                 "${controller.timeRemaining.value.inSeconds % 60}s", style: TextStyle(color: Colors.red, fontSize: 3.w),),
//             SizedBox(height: 20),
//             ...controller.prayerTimes.keys.map((key) {
//               final time = controller.getAdjustedTime(key);
//               return Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                           child: Text(          
//                               "${key.capitalizeFirst}: ${DateFormat("h:mm a").format(time)}", style: TextStyle(color: Colors.green, fontSize: 3.w),)),
//                       SizedBox(
//                         width: 60,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             labelText: "+/-Min",
//                             border: OutlineInputBorder(),
//                           ),
//                           keyboardType: TextInputType.number,
//                           onSubmitted: (value) {
//                             final int? minutes = int.tryParse(value);
//                             if (minutes != null) {
//                               controller.adjustPrayerTime(key, minutes);
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         );
//       }),
//     );
//   }
// }