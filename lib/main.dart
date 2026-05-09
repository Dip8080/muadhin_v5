// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:muaddin/features/Home/controller/brightness_controller.dart';
// import 'package:muaddin/features/Home/controller/prayer_time_controller_four.dart';
// import 'package:muaddin/features/Home/controller/wallpaper_controller.dart';
// import 'package:muaddin/features/player_two/controller/audio_controller.dart';
// import 'package:muaddin/features/player_two/controller/audio_controller_two.dart';
// import 'package:muaddin/firebase_options.dart';
// import 'package:muaddin/muaddin.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:intl/date_symbol_data_local.dart';
// // import 'package:muaddin/features/live/controller/live_tv_controller.dart';
// import 'package:muaddin/features/update/controller/update_controller.dart';

// void main() async {
//   tz.initializeTimeZones();
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
//   await initializeDateFormatting('nl', null);
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
//   Get.put(AudioController());
//   Get.put(BrightnessController());
//   Get.put(PrayerTimeControllerFour());
//   Get.put(WallpaperController());
//   Get.put(AudioControllerTwo());
//   // Get.put(LiveTvController());
//   Get.put(UpdateController());

//   runApp(const Muaddin());
// }


import 'package:flutter/material.dart';
import 'package:muaddin/core/utility/app_initializer.dart';
import 'package:muaddin/core/widgets/restart_widget.dart';

import 'package:muaddin/muaddin.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.init();

  runApp(
    RestartWidget(
      child: const Muaddin(),
    ),
  );
}

// this need to be modified to be able to restart the app when the user change the language or theme
// this need to be modified to be able to restart the app when the user change the language or theme
// this need to be modified to be able to restart the app when the user change the language or theme
// this need to be modified to be able to restart the app when the user change the language or theme
// this need to be modified to be able to restart the app when the user change the language or theme