import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BrightnessController extends GetxController {
  var brightness = 0.5.obs;
  var isBrightnessSliderVisiable = false.obs;
  var settingPreset = 'Settings'.tr.obs;
  var isTimePrestClicked = false.obs;
  var isLanguagePresetClicked = false.obs;
  var isAdhanSoundClicked = false.obs;
  var automaticTime = false.obs;
  var isExpanded = false.obs;

  var selectedSection = ''.obs;


  @override
  void onInit() {
    super.onInit();
    getCurrentBrightness();
  }

  void toggleSection(String section) {
  if (selectedSection.value == section) {
    // If clicking same section → close it
    selectedSection.value = '';
  } else {
    // If different → open new one
    selectedSection.value = section;
  }
}


void toggleExpanded() {
  isExpanded.value = !isExpanded.value;
}

  void setSettingsPrest(
    String newPreset,
  ) {
    settingPreset.value = newPreset;
    if (newPreset.toLowerCase() == 'time') {
      isTimePrestClicked.value = true;
    } else if (newPreset.toLowerCase() == 'language') {
      isLanguagePresetClicked.value = true;
    } else {
      isAdhanSoundClicked.value = true;
    }
  }

  void setAutomaticTime() {
    automaticTime.value = !automaticTime.value;
    print(automaticTime.value);
  }

  Future<void> getCurrentBrightness() async {
    try {
      final currentBrightness = await ScreenBrightness().system;
      brightness.value = currentBrightness;
    } catch (e) {
      print('Error fetching curren brightness');
    }
  }

  Future<void> setBrightness(double value) async {
    try {
      await ScreenBrightness().setSystemScreenBrightness(value);
      brightness.value = value;
    } catch (e) {
      print("Error setting brightness: $e");
    }
  }

  void toogleBrightnessSlider() {
    isBrightnessSliderVisiable.value = !isBrightnessSliderVisiable.value;
  }
}
