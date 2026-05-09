import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muaddin/core/utility/app_initializer.dart';
import 'package:muaddin/core/widgets/dynamic_text_widget.dart';
import 'package:muaddin/core/widgets/restart_widget.dart';
import 'package:muaddin/core/widgets/setting_tile.dart';
import 'package:muaddin/features/Home/controller/brightness_controller.dart';
import 'package:muaddin/features/Home/controller/prayer_time_controller_four.dart';
import 'package:muaddin/features/Home/controller/wallpaper_controller.dart';
import 'package:muaddin/features/player_two/controller/audio_controller.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:android_intent_plus/android_intent.dart';
import 'package:app_settings/app_settings.dart';

// vrgr
class Transparent_drawer_settings_two extends StatelessWidget {
  final BuildContext context;

  Transparent_drawer_settings_two({required this.context});
  final AudioController audioController = Get.find();
  final BrightnessController brightnessController = Get.find();
  // final ClockController clockController = Get.find();
  final WallpaperController wallpaperController = Get.find();
  // final PrayerTimeController prayerTimeController = Get.find();
  // final PrayerTimeControllerThree controller = Get.find();
  final PrayerTimeControllerFour controllerTwo = Get.find();

  @override
  Widget build(BuildContext context) {
    final TextEditingController fazarController = TextEditingController();
    final TextEditingController duhorController = TextEditingController();
    final TextEditingController asorController = TextEditingController();
    final TextEditingController magribController = TextEditingController();
    final TextEditingController ishaController = TextEditingController();
    final timeZones = tz.timeZoneDatabase.locations.keys.toList();

    TextTheme pickerTextTheme(BuildContext context) {
      final base = Theme.of(context).textTheme;

      return base.copyWith(
        headlineSmall: base.headlineSmall?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: base.titleLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          // color: Colors.red
        ),
        titleMedium: base.titleMedium?.copyWith(
          fontSize: 14,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          fontSize: 14,
        ),
        bodyMedium: base.bodyMedium?.copyWith(
          fontSize: 13,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    void openBluetoothSettings() {
      const intent = AndroidIntent(
        action: 'android.settings.BLUETOOTH_SETTINGS',
      );
      intent.launch();
    }

    Future<void> _openManualDateTimePicker(BuildContext context) async {
      final controller = Get.find<PrayerTimeControllerFour>();
      final now = controller.effectiveNow;

      final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              useMaterial3: false,
              textTheme: pickerTextTheme(context),
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0, // ✅ Prevent tablet scaling bug
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1220, // ✅ Tablet-safe width
                    maxHeight: 1080,
                  ),
                  child: child!,
                ),
              ),
            ),
          );
        },
      );

      if (pickedDate == null) return;

      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              useMaterial3: false,
              textTheme: pickerTextTheme(context),
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 1220, maxHeight: 1080),
                  child: child!,
                ),
              ),
            ),
          );
        },
      );

      if (pickedTime == null) return;

      final location = tz.getLocation(
        controller
            .countryTimeZones[controller.selectedCountry.value.toLowerCase()]!,
      );

      controller.manualDateTime.value = tz.TZDateTime(
        location,
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      controller.isManualTimeEnabled.value = true;
      controller.updatePrayerStatus();
    }

    print(timeZones.map((e) => e.toString()));
    return Obx(() {
      return Drawer(
        width: 35.w,
        backgroundColor: Colors.amber.withOpacity(0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              // color: Colors.white70.withOpacity(0.1),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18.h,
                    child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        brightnessController
                                            .settingPreset.value = 'Settings';
                                        brightnessController
                                            .isTimePrestClicked.value = false;
                                        brightnessController
                                            .isLanguagePresetClicked
                                            .value = false;
                                        brightnessController
                                            .isAdhanSoundClicked.value = false;
                                        Navigator.pop(context);
                                        audioController
                                            .toogleOpenAudioPlayer(false);
                                      },
                                      child: circle_with_icon(Icons.close),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  '${brightnessController.settingPreset.value}'
                                      .tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 4.w, color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  // henloofe
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // GestureDetector(
                        //   onTap: () {
                        //     brightnessController.setSettingsPrest('Time');
                        //     brightnessController.automaticTime.value = true;
                        //     brightnessController.toggleSection('time');
                        //   },
                        //   child: Text(
                        //     'time'.tr,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodySmall!
                        //         .copyWith(
                        //             fontSize: 2.5.w,
                        //             color: Colors.white,
                        //             decoration: TextDecoration.underline,
                        //             decorationColor: Colors.white24),
                        //   ),
                        // ),
                        SettingsTile(
                            icon: Icons.alarm,
                            title: 'time'.tr,
                            subtitle: 'setTimezoneAdjustPrayerTimes'.tr,
                            onTap: () {
                              brightnessController.toggleExpanded();
                              brightnessController.setSettingsPrest('Time');
                              brightnessController.automaticTime.value = true;
                              brightnessController.toggleSection('time');
                            }),
                        // brightnessController.isTimePrestClicked == true
                        brightnessController.selectedSection.value == 'time'
                            ? Container(
                                // height: 27.w,
                                width: 100.w,
                                // color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      brightnessController
                                                  .automaticTime.value ==
                                              true
                                          ? Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 2.w,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        _openManualDateTimePicker(
                                                            context),
                                                    child: Text(
                                                      'set_date_&_time'.tr,
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            Colors.white24,
                                                        color: Colors.white,
                                                        fontSize: 2.w,
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 1.w,
                                                  ),

                                                  GestureDetector(
                                                    onTap: () {
                                                      _openManualDateTimePicker(
                                                          context);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 14.w,
                                                          height: 15.h,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  1.w),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .blueAccent
                                                                .withOpacity(
                                                                    0.1),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: .4,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  // Icon(
                                                                  //   Icons
                                                                  //       .punch_clock_outlined,
                                                                  //   size: 3.5.w,
                                                                  //   color: Colors
                                                                  //       .blueAccent,
                                                                  // ),
                                                                  Image.asset(
                                                                    'assets/icons/clock.png',
                                                                    width:
                                                                        2.3.w,
                                                                    height:
                                                                        2.3.w,
                                                                    // color: Colors
                                                                    //     .white,
                                                                    color: Colors
                                                                        .blueAccent,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text('time'
                                                                      .tr),

                                                                  // SizedBox(
                                                                  //   width: 10.w,
                                                                  // )
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  // Text('time'.tr),
                                                                  SizedBox(
                                                                    width:
                                                                        2.5.w,
                                                                  ),
                                                                  Text(
                                                                    // '${clockController.getCurrentTimeInSelectedTimeZone()}'),
                                                                    '${controllerTwo.getCurrentTimeInSelectedTimeZone()}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            2.5.w),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 14.w,
                                                          height: 15.h,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  1.w),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .blueAccent
                                                                .withOpacity(
                                                                    0.1),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: .4,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  // Icon(
                                                                  //   Icons
                                                                  //       .calendar_month_outlined,
                                                                  //   size: 3.5.w,
                                                                  //   color: Colors
                                                                  //       .blueAccent,
                                                                  // ),
                                                                  Image.asset(
                                                                    'assets/icons/calendar.png',
                                                                    width:
                                                                        2.3.w,
                                                                    height:
                                                                        2.3.w,
                                                                    // color: Colors
                                                                    //     .white,
                                                                    color: Colors
                                                                        .blueAccent,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text('dated'
                                                                      .tr),
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  // Text('time'.tr),

                                                                  Text(
                                                                    // '${clockController.getCurrentTimeInSelectedTimeZone()}'),
                                                                    '${controllerTwo.getCurrentDateInSelectedTimeZone()}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            1.8.w),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 2.w,
                                                  // ),
                                                  Obx(() => controllerTwo
                                                          .isManualTimeEnabled
                                                          .value
                                                      ? TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            controllerTwo
                                                                .isManualTimeEnabled
                                                                .value = false;
                                                            controllerTwo
                                                                .manualDateTime
                                                                .value = null;
                                                            controllerTwo
                                                                .updatePrayerStatus();
                                                          },
                                                          child: Text(
                                                            'reset'.tr.tr,
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  Colors
                                                                      .white24,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 2.w,
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox()),
                                                  SizedBox(
                                                    height: 2.w,
                                                  ),

                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('set_time_zone'.tr),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.w,
                                                  ),

                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(2.w),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blueAccent
                                                          .withOpacity(0.1),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: .4,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              'assets/icons/earth.png',
                                                              width: 3.w,
                                                              height: 3.w,
                                                              // color: Colors
                                                              //     .white,
                                                              color: Colors
                                                                  .blueAccent,
                                                            ),
                                                            SizedBox(
                                                                width: 2.w),
                                                            Text(
                                                              'select_country'
                                                                  .tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      2.w),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 1.5.h),
                                                        Obx(() {
                                                          return Container(
                                                            height: 5.h,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        2.w),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 0.5),
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            child:
                                                                DropdownButton<
                                                                    String>(
                                                              value: controllerTwo
                                                                      .selectedCountry
                                                                      .value
                                                                      .isEmpty
                                                                  ? null
                                                                  : controllerTwo
                                                                      .selectedCountry
                                                                      .value,
                                                              isExpanded: true,
                                                              hint: Text(
                                                                'Select Country',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.7),
                                                                  fontSize:
                                                                      2.3.w,
                                                                ),
                                                              ),
                                                              underline:
                                                                  SizedBox(),
                                                              icon: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  color: Colors
                                                                      .white),
                                                              dropdownColor: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.9),
                                                              items: controllerTwo
                                                                  .countries
                                                                  .map(
                                                                      (country) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value:
                                                                      country,
                                                                  child: Text(
                                                                    country,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          1.5.w,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged:
                                                                  (value) {
                                                                final Map<
                                                                        String,
                                                                        String>
                                                                    defaultCityByCountry =
                                                                    {
                                                                  'Netherlands':
                                                                      'Gouda',
                                                                  'France':
                                                                      'Paris',
                                                                  'Germany':
                                                                      'Berlin',
                                                                  'Belgium':
                                                                      'Brussels',
                                                                };

                                                                final Map<
                                                                        String,
                                                                        String>
                                                                    countryTimeZones =
                                                                    {
                                                                  'Netherlands':
                                                                      'Europe/Amsterdam',
                                                                  'Germany':
                                                                      'Europe/Berlin',
                                                                  'France':
                                                                      'Europe/Paris',
                                                                  'Belgium':
                                                                      'Europe/Brussels',
                                                                };

                                                                if (value !=
                                                                    null) {
                                                                  controllerTwo
                                                                      .selectedCountry
                                                                      .value = value;
                                                                  controllerTwo
                                                                      .selectedCity
                                                                      .value = defaultCityByCountry[
                                                                          value] ??
                                                                      '';
                                                                  controllerTwo
                                                                      .selectedTimeZone
                                                                      .value = countryTimeZones[
                                                                          value] ??
                                                                      'Europe/Amsterdam';
                                                                  controllerTwo
                                                                      .fetchPrayerTimes();
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                  // new code for  country picker
                                                  SizedBox(
                                                    height: 1.w,
                                                  ),

                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(2.w),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blueAccent
                                                          .withOpacity(0.1),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: .4,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                             Image.asset(
                                                                    'assets/icons/state.png',
                                                                    width: 3.w,
                                                                    height: 3.w,
                                                                    // color: Colors
                                                                    //     .white,
                                                                    color: Colors.blueAccent,
                                                                  ),
                                                            SizedBox(
                                                                width: 2.w),
                                                            Text(
                                                              'select_state'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      2.1.w),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 1.5.h),
                                                        Obx(() {
                                                          return Container(
                                                            height: 5.h,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        2.w),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 0.5),
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            child:
                                                                DropdownButton<
                                                                    String>(
                                                              value: controllerTwo
                                                                      .selectedCity
                                                                      .value
                                                                      .isEmpty
                                                                  ? null
                                                                  : controllerTwo
                                                                      .selectedCity
                                                                      .value,
                                                              isExpanded: true,
                                                              hint: Text(
                                                                'Select City',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.7),
                                                                  fontSize:
                                                                      2.3.w,
                                                                ),
                                                              ),
                                                              underline:
                                                                  SizedBox(),
                                                              icon: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  color: Colors
                                                                      .white),
                                                              // icon: Image.asset(
                                                              //   'assets/icons/clock.png',
                                                              //   width: 4.w,
                                                              //   height: 4.w,
                                                              //   color: Colors
                                                              //       .white,
                                                              // ),
                                                              dropdownColor: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.9),
                                                              items: controllerTwo
                                                                  .cities
                                                                  .map((city) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: city,
                                                                  child: Text(
                                                                    city,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          1.5.w,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged:
                                                                  (value) {
                                                                if (value !=
                                                                    null) {
                                                                  controllerTwo
                                                                      .selectedCity
                                                                      .value = value;
                                                                  controllerTwo
                                                                      .fetchPrayerTimes();
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      SizedBox(
                                        height: 1.5.w,
                                      ),
                                      Row(
                                        children: [
                                          Text('Set Prayer Time'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.5.w,
                                      ),
                                      ...controllerTwo.prayerTimes.keys
                                          .map((key) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: .4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w, vertical: 1.h),
                                          margin: EdgeInsets.symmetric(
                                              vertical: .5.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Prayer name
                                              DynamicTextWidget(
                                                  text:
                                                      '${key.toString().capitalizeFirst}',
                                                  fontSize: 2),

                                              // Minus and Plus buttons
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons
                                                            .remove_circle_outline,
                                                        color: Colors.white),
                                                    onPressed: () {
                                                      controllerTwo
                                                          .decreasePrayerTime(key
                                                              .toString()
                                                              .toLowerCase());
                                                      // controllerTwo.adjustPrayerTime(
                                                      //      key, -1
                                                      //     ); // decrease 1 min
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color: Colors.white),
                                                    onPressed: () {
                                                      controllerTwo
                                                          .increasePrayerTime(key
                                                              .toString()
                                                              .toLowerCase());
                                                      // controllerTwo.adjustPrayerTime(
                                                      //     key,
                                                      //     1); // increase 1 min
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList()
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        // need t update the ui
                        // GestureDetector(
                        //   onTap: () {
                        //     brightnessController.setSettingsPrest('language');
                        //     brightnessController.toggleSection('language');
                        //   },
                        //   child: Text(
                        //     'language'.tr,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodySmall!
                        //         .copyWith(
                        //             fontSize: 2.5.w,
                        //             color: Colors.white,
                        //             decoration: TextDecoration.underline,
                        //             decorationColor: Colors.white24),
                        //   ),
                        // ),
                        SettingsTile(
                            icon: Icons.language,
                            title: 'language'.tr,
                            subtitle: 'selectLanguage'.tr,
                            onTap: () {
                              brightnessController.setSettingsPrest('language');
                              brightnessController.toggleSection('language');
                            }),
                        // brightnessController.isLanguagePresetClicked == true
                        brightnessController.selectedSection.value == 'language'
                            ? Container(
                                margin: EdgeInsets.only(top: 1.w, bottom: 1.w),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Get.updateLocale(Locale('nl'));
                                          wallpaperController
                                              .changeLanguage('nl');
                                          audioController.isHadia.value = false;
                                          controllerTwo.selectedLanguage.value =
                                              'nl';
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: .4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text('Dutch'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.updateLocale(Locale('ar'));
                                          // wallpaperController
                                          //     .changeLanguage('ar');
                                          wallpaperController
                                              .changeLanguage('ar');
                                          audioController.isHadia.value = false;
                                          controllerTwo.selectedLanguage.value =
                                              'ar';
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: .4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text('Arabic'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.updateLocale(Locale('en'));
                                          wallpaperController
                                              .changeLanguage('en');
                                          audioController.isHadia.value = true;
                                          // clockController.selectedLanguage.value =
                                          //     'en';
                                          controllerTwo.selectedLanguage.value =
                                              'en';
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: .4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text('English'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.updateLocale(Locale('fr'));
                                          wallpaperController
                                              .changeLanguage('fr');
                                          audioController.isHadia.value = true;
                                          controllerTwo.selectedLanguage.value =
                                              'fr';
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: .4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text('French'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.updateLocale(Locale('de'));
                                          wallpaperController
                                              .changeLanguage('de');
                                          audioController.isHadia.value = true;
                                          controllerTwo.selectedLanguage.value =
                                              'de';
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: .4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text('German'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        // GestureDetector(
                        //   onTap: () {
                        //     brightnessController.setSettingsPrest('Adhan');
                        //     brightnessController.toggleSection('adhan');
                        //   },
                        //   child: Text(
                        //     // 'language'.tr,
                        //     'Adhan',
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodySmall!
                        //         .copyWith(
                        //             fontSize: 2.5.w,
                        //             color: Colors.white,
                        //             decoration: TextDecoration.underline,
                        //             decorationColor: Colors.white24),
                        //   ),
                        // ),
                        SettingsTile(
                            icon: Icons.volume_up,
                            title: 'adhan'.tr,
                            subtitle: 'selectAdhanSound'.tr,
                            onTap: () {
                              brightnessController.toggleExpanded();
                              brightnessController.setSettingsPrest('Adhan');
                              brightnessController.toggleSection('adhan');
                            }),
                        //  brightnessController.isAdhanSoundClicked.value == true
                        brightnessController.selectedSection.value == 'adhan'
                            ? Container(
                                height: 40.w,
                                child: Padding(
                                  padding: EdgeInsets.all(.5.w),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: _buildSurahPlayerBody(
                                            audioController),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 1.5.w,
                                              vertical: 00.w),
                                          // decoration: BoxDecoration(
                                          //     color: Colors.white30),
                                          // decoration: BoxDecoration(
                                          //   color: Colors.blueAccent
                                          //       .withOpacity(0.1),
                                          //   border: Border.all(
                                          //     color: Colors.white,
                                          //     width: .4,
                                          //   ),
                                          //   borderRadius:
                                          //       BorderRadius.circular(10),
                                          // ),
                                          child: ListView.builder(
                                            itemCount: audioController
                                                .muajjinName.length,
                                            itemBuilder: (context, index) {
                                              final PrayerTimeControllerFour
                                                  prayerTimeControllerFour =
                                                  Get.find();
                                              return GestureDetector(
                                                onTap: () {
                                                  prayerTimeControllerFour
                                                      .changeMuadhin(
                                                          audioController
                                                              .adhanUrl[index]);
                                                  audioController
                                                      .playAdhan(index);
                                                  audioController
                                                      .adhanIndex.value = index;
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: .8.h),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueAccent
                                                        .withOpacity(0.1),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: .4,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 14.0,
                                                      horizontal: 16.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          diamond_container(
                                                              index),
                                                          SizedBox(
                                                            width: 1.w,
                                                          ),
                                                          Text(
                                                            audioController
                                                                    .muajjinName[
                                                                index],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24),
                                                          ),
                                                          SizedBox(
                                                            width: 0.w,
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // prayerTimeControllerFour.adhanVoice.value = audioController.adhanUrl[index];
                                                          prayerTimeControllerFour
                                                              .changeMuadhin(
                                                                  audioController
                                                                          .adhanUrl[
                                                                      index]);
                                                          print(
                                                              'adhan url - ${prayerTimeControllerFour.adhanVoice.value}');
                                                          audioController
                                                              .playAdhan(index);
                                                          audioController
                                                              .adhanIndex
                                                              .value = index;
                                                        },
                                                        child: Container(
                                                          width: 2.w,
                                                          height: 3.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                              color: audioController
                                                                          .suraIndex
                                                                          .value ==
                                                                      index
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .transparent,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                            audioController
                                                                        .adhanIndex
                                                                        .value ==
                                                                    index
                                                                ? Icons
                                                                    .play_arrow
                                                                : Icons
                                                                    .play_arrow,
                                                            color: audioController
                                                                        .adhanIndex
                                                                        .value ==
                                                                    index
                                                                ? Colors.black
                                                                : Colors.white,
                                                            weight: 4,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SettingsTile(
                            icon: Icons.wb_sunny_outlined,
                            title: 'brightness'.tr,
                            subtitle: 'set_brightness_level'.tr,
                            onTap: () {
                              brightnessController.toggleExpanded();
                              brightnessController.toogleBrightnessSlider();
                            }),
                        // SizedBox(
                        //   height: 1.w,
                        // ),
                        brightnessController.isBrightnessSliderVisiable.value
                            ? Container(
                                width: 30.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey.withOpacity(.3),
                                ),
                                height: 3.w,
                                child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Slider(
                                      activeColor: Colors.white,
                                      min: 0.0,
                                      max: 1.0,
                                      value:
                                          brightnessController.brightness.value,
                                      onChanged: (value) {
                                        brightnessController
                                            .setBrightness(value);
                                      }),
                                ),
                              )
                            : SizedBox.shrink(),

                        SettingsTile(
                          icon: Icons.bluetooth,
                          title: 'bluetooth'.tr,
                          subtitle: 'connectBluetoothDevices'.tr,
                          onTap: () {
                            openBluetoothSettings();
                          },
                        ),

                        SettingsTile(
                            icon: Icons.wifi,
                            title: 'wifi'.tr,
                            subtitle: 'connectWifi'.tr,
                            onTap: () {
                              AppSettings.openAppSettingsPanel(
                                  AppSettingsPanelType.wifi);
                            }),
                        SettingsTile(
                          icon: Icons.restart_alt,
                          // title: 'bluetooth'.tr,
                          title: 'restart_muadhin'.tr,
                          subtitle: 'click_restart_muadhin'.tr,
                          onTap: () async {
                            final ctx = context;

                            Get.reset();
                            await AppInitializer.init();

                            Future.microtask(() {
                              RestartWidget.restartApp(ctx);
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Container diamond_container(int index) {
    return Container(
      height: 4.5.w,
      width: 4.5.w,
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/icons/rec.png'), fit: BoxFit.contain),
        // border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }

  Container circle_with_icon(IconData icon) {
    return Container(
      width: 4.5.w,
      height: 4.5.w,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
          shape: BoxShape.circle),
      child: Icon(
        size: 2.4.w,
        icon,
        color: Colors.white,
        weight: 6,
      ),
    );
  }

  Widget _buildSurahPlayerBody(AudioController controller) {
    // final PrayerTimeController prayerTimeController = Get.find();
    return Obx(() {
      String formatDuration(Duration duration) {
        final minutes = duration.inMinutes.toString().padLeft(2, '0');
        final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
        return "$minutes:$seconds";
      }

      bool isPlaying = controller.isPlaying.value;
      int surahIndex = controller.adhanIndex.value;
      final currantTime = formatDuration(audioController.currentPosition.value);
      final totalTime = formatDuration(audioController.totalDuration.value);

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  audioController.stopAudio();
                  Navigator.pop(context);
                },
                child: circle_with_icon(Icons.close),
              ),
              SizedBox(
                width: 1.5.w,
              ),
              SizedBox(
                  width: 3.5.w,
                  height: 3.5.w,
                  child: diamond_container(surahIndex)),
              SizedBox(
                width: .6.w,
              ),
              Text(
                "${controller.muajjinName[surahIndex]}",
                style: TextStyle(
                    fontSize: 2.w,
                    fontWeight: FontWeight.w100,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    controller.toogleMute();
                  },
                  icon: Icon(
                    !controller.isMuted.value
                        ? Icons.volume_up
                        : Icons.volume_mute,
                    color: Colors.white,
                  )),
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          audioController.skipBackward();
                        },
                        icon: Icon(
                          Icons.fast_rewind,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 1.w,
                    ),
                    isPlaying
                        ? GestureDetector(
                            onTap: () {
                              // prayerTimeController.updateAdhanString(
                              //     controller.adhanUrl[surahIndex]);
                              controller.isPlaying.value = false;
                              controller.pauseAudio();
                            },
                            child: circle_with_icon(Icons.pause))
                        : GestureDetector(
                            onTap: () {
                              controller.isPlaying.value = true;
                              controller.playAudio();
                            },
                            child: circle_with_icon(Icons.play_arrow)),
                    SizedBox(
                      width: 1.w,
                    ),
                    IconButton(
                        onPressed: () {
                          audioController.skipForward();
                        },
                        icon: Icon(
                          Icons.fast_forward,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Container()
            ],
          ),
          Slider(
            activeColor: Colors.white,
            value: audioController.position.value.inSeconds.toDouble(),
            max: audioController.duration.value.inSeconds.toDouble(),
            onChanged: (value) {
              // await _audioPlayer.seek(Duration(seconds: value.toInt()));
              // return audioController.seekAudio(value);
              audioController.audioPlayer
                  .seek(Duration(seconds: value.toInt()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 1.8.w,
              ),
              Text(
                '${formatDuration(audioController.position.value)}',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              SizedBox(
                width: 15.8.w,
              ),
              Text(
                '${totalTime}',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}
