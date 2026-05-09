import 'package:get/get.dart';

import 'package:muaddin/features/Home/controller/brightness_controller.dart';
import 'package:muaddin/features/Home/controller/prayer_time_controller_four.dart';
import 'package:muaddin/features/Home/controller/wallpaper_controller.dart';
import 'package:muaddin/features/player_two/controller/audio_controller.dart';
import 'package:muaddin/features/player_two/controller/audio_controller_two.dart';
import 'package:muaddin/features/update/controller/update_controller.dart';

// class InitialBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(AudioController());
//     Get.put(AudioControllerTwo());
//     Get.put(BrightnessController());
//     Get.put(PrayerTimeControllerFour());
//     Get.put(WallpaperController());
//     Get.put(UpdateController());
//   }
// }

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AudioController(), fenix: true);
    Get.lazyPut(() => AudioControllerTwo(), fenix: true);
    Get.lazyPut(() => BrightnessController(), fenix: true);
    Get.lazyPut(() => PrayerTimeControllerFour(), fenix: true);
    Get.lazyPut(() => WallpaperController(), fenix: true);
    Get.lazyPut(() => UpdateController(), fenix: true); // 🔥 important
  }
}
