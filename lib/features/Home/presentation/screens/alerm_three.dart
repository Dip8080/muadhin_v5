import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muaddin/core/utility/app_initializer.dart';
import 'package:muaddin/core/utility/assets_paths.dart';
import 'package:muaddin/core/widgets/dynamic_text_widget.dart';
import 'package:muaddin/core/widgets/restart_widget.dart';
import 'package:muaddin/features/Home/controller/brightness_controller.dart';
import 'package:muaddin/features/Home/controller/prayer_time_controller_four.dart';
import 'package:muaddin/features/Home/controller/wallpaper_controller.dart';
import 'package:muaddin/features/Home/presentation/widgets/circle_prayer_time.dart';
import 'package:muaddin/features/Home/presentation/widgets/transparent_drawer.dart';
import 'package:muaddin/features/Home/presentation/widgets/transparent_drawer_settings_two.dart';
import 'package:muaddin/features/Home/presentation/widgets/transparent_drawer_three.dart';
import 'package:muaddin/features/player_two/controller/audio_controller.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';


class AlermThree extends StatefulWidget {
  const AlermThree({super.key});

  @override
  State<AlermThree> createState() => _AlermThreeState();
}

class _AlermThreeState extends State<AlermThree> {
  // final PrayerTimeController prayerTimeController = Get.find();
  final AudioController audioController = Get.find();
  // final ClockController clockController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final PrayerTimeControllerFour controllerTwo = Get.find();
  final WallpaperController wallpaperController = Get.find();
  // final LiveTvController controller = Get.find();
  late Timer _timer;
  final isDutch = true;
  late DateTime _currentTime;
  Duration _remainingTime = Duration.zero;
  // final TimeOfDay targetTime = TimeOfDay(hour: 4, minute: 50);
  final TimeOfDay targetTime = TimeOfDay(hour: 4, minute: 20);
  int currentIndex = 0;
  int currentHadithIndex = 0;
  DateTime? lastWallpaperChangeTime;
  DateTime? lastHadithChangeTime;
  double _currentVolume = 1;

  final AudioPlayer _player = AudioPlayer();
  bool isMuted = false;
  void muteAudio() {
    _player.setVolume(0.0);
    setState(() {
      isMuted = true;
    });
  }

  void unmuteAudio() {
    _player.setVolume(1.0);
    setState(() {
      isMuted = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestPermissions(context);
    });

    lastWallpaperChangeTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    VolumeController.instance.addListener((volume) {
      setState(() {
        _currentVolume = volume;
      });
    });
  }
// new update

  void openBluetoothSettings() {
    const intent = AndroidIntent(
      action: 'android.settings.BLUETOOTH_SETTINGS',
    );
    intent.launch();
  }

  Future<void> _requestPermissions(BuildContext context) async {
    // Check current connectivity
    // Check current connectivity
    // Check current connectivity
    // Check current connectivity
    // Check current connectivity
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // Internet is available, continue
      Get.to(() => AlermThree());
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 85.w,
              height: 80.h,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage('assets/images/popup_wifi.jpeg'),
                    fit: BoxFit.cover,
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 45.h),

                  /// TITLE
                  Text(
                    "connect_wifi_title".tr,
                    style: TextStyle(
                      fontSize: 2.3.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 5),

                  /// DESCRIPTION
                  Text(
                    "connect_wifi_description".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 1.8.w,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// OPEN WIFI BUTTON
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      AppSettings.openAppSettingsPanel(
                        AppSettingsPanelType.wifi,
                      );
                      // await Get.reset();
                      await AppInitializer.init();
                      RestartWidget.restartApp(context);
                    },
                    child: Container(
                      width: 30.w,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFE6EFA6),
                            Color(0xFF8ED6D8),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "open_wifi_settings".tr,
                          style: TextStyle(
                              fontSize: 2.3.w,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// CANCEL
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "cancel".tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 2.w,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> openLiveStream(String videoId) async {
    final Uri youtubeApp = Uri.parse("vnd.youtube://$videoId");
    final Uri youtubeWeb =
        Uri.parse("https://www.youtube.com/watch?v=$videoId");

    if (await canLaunchUrl(youtubeApp)) {
      await launchUrl(youtubeApp);
    } else {
      await launchUrl(
        youtubeWeb,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  // final PrayerTimeControllerThree controller = Get.find();
  @override
  Widget build(BuildContext context) {
    HijriCalendar _today = HijriCalendar.now();
    // _today.hDay = _today.hDay - 1;
    _today.hDay = _today.hDay;
    final BrightnessController brightnessController = Get.find();

    return Obx(() {
      wallpaperController.maybePickDaily();
      // String currentime = clockController.getCurrentTimeInSelectedTimeZone();
      String currentime = controllerTwo.getCurrentTimeInSelectedTimeZone();
      return GestureDetector(
        onLongPressUp: () async {
          // _changeHadith();
          // _changeWallpaper();
          await wallpaperController.pickRandom(force: true);
          // wallpaperController.changeHadith();
          wallpaperController.nextHadith();
        },
        onDoubleTap: () {
          print('double tap detected');
          controllerTwo.testAdhan();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage(wallpapers[currentIndex]),
                    //     fit: BoxFit.fill),
                    image: DecorationImage(
                        image: wallpaperController
                                .currentImageUrl.value.isNotEmpty
                            ? CachedNetworkImageProvider(
                                wallpaperController.currentImageUrl.value)
                            : const AssetImage('assets/images/nineteen.jpg'),
                        fit: BoxFit.fill),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(1.w),
                    width: 100.w,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(.6)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            printInfo(info: 'into the reset function !!!!');
                            // Get.reset();
                            // await AppInitializer.init();

                            // RestartWidget.restartApp(context);
                            // final ctx = context;

                            // Get.reset();
                            // await AppInitializer.init();

                            // Future.microtask(() {
                            //   RestartWidget.restartApp(ctx);
                            // });
                            // Get.to(() => PrayerTimeScreenDemoTwo());
                            // openBluetoothSettings();
                          },
                          // child: audioController.isHadia.value
                          //     ? surahText(hadith)
                          //     : surahText(hadithInDutch),
                          child: surahText(
                            wallpaperController.currentHadith,
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              // color: Colors.red,
                              height: 39.h,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 92.w,
                                  ),
                                  Container(
                                    width: 5.w,
                                    height: 100.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            audioController
                                                .isVolumeSliderVisible
                                                .value = false;
                                            brightnessController
                                                .isBrightnessSliderVisiable
                                                .value = false;
                                            audioController
                                                .toogleOpenAudioPlayer(true);
                                            audioController
                                                .toggleShowAdhanTimesOnSide(
                                                    true);
                                            audioController.activeDrawer.value =
                                                AppDrawerType.player;
                                            scaffoldKey.currentState
                                                ?.openEndDrawer();
                                          },
                                          child: sideBar_child(
                                              AssetsPaths.icon_one),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            audioController.activeDrawer.value =
                                                AppDrawerType.ruqya;
                                            audioController
                                                .toggleShowAdhanTimesOnSide(
                                                    true);
                                            scaffoldKey.currentState
                                                ?.openEndDrawer();
                                          },
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.black.withOpacity(.3),
                                            child: Image(
                                              image: AssetImage(
                                                AssetsPaths.icon_five,
                                              ),
                                              fit: BoxFit.contain,
                                              width: 40,
                                            ),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   // onTap: () {
                                        //   //   audioController
                                        //   //       .isVolumeSliderVisible
                                        //   //       .value = false;
                                        //   //   brightnessController
                                        //   //       .toogleBrightnessSlider();
                                        //   //   Future.delayed(
                                        //   //       const Duration(seconds: 3), () {
                                        //   //     brightnessController
                                        //   //         .toogleBrightnessSlider();
                                        //   //     ;
                                        //   //   });
                                        //   // },
                                        //   onTap: () {
                                        //     showHaramOptions(context);
                                        //     // Get.to(() => LiveTvScreen());
                                        //   },
                                        //   child: CircleAvatar(
                                        //       radius: 30,
                                        //       backgroundColor:
                                        //           Colors.black.withOpacity(.3),
                                        //       child: Image(
                                        //         image: AssetImage(
                                        //           AssetsPaths.icon_six,
                                        //         ),
                                        //         fit: BoxFit.contain,
                                        //         width: 40,
                                        //       )),
                                        // ),
                                        GestureDetector(
                                          onLongPress: () {
                                            print('I was long pressed');
                                            muteAudio();
                                          },
                                          onLongPressUp: () {
                                            print(
                                                'I was released from long pressed');
                                            muteAudio();
                                          },
                                          onTap: () {
                                            brightnessController
                                                .isBrightnessSliderVisiable
                                                .value = false;
                                            audioController
                                                .toggleVolumeSlider();
                                            Future.delayed(
                                                const Duration(seconds: 3), () {
                                              audioController
                                                  .toggleVolumeSlider();
                                            });
                                          },
                                          onDoubleTap: () {
                                            controllerTwo.toggleMute();
                                          },
                                          // child: sideBar_child(
                                          //     AssetsPaths.icon_two),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.black.withOpacity(.3),
                                            child: Icon(
                                              controllerTwo.isMuted.value
                                                  ? Icons.volume_off
                                                  : Icons.volume_up,
                                              color:
                                                  Colors.white.withOpacity(.6),
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            audioController
                                                .isVolumeSliderVisible
                                                .value = false;
                                            brightnessController
                                                .isBrightnessSliderVisiable
                                                .value = false;
                                            audioController
                                                .toogleOpenAudioPlayer(false);
                                            audioController.activeDrawer.value =
                                                AppDrawerType.settings;
                                            scaffoldKey.currentState
                                                ?.openEndDrawer();
                                            audioController
                                                .toggleShowAdhanTimesOnSide(
                                                    true);
                                          },
                                          child: sideBar_child(
                                              AssetsPaths.icon_four),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // need to
                            Positioned(
                              right: 6.w,
                              top: 14.w,
                              child: Obx(() {
                                if (audioController
                                    .isVolumeSliderVisible.value) {
                                  return Container(
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
                                          // value: audioController.volume.value,
                                          value: _currentVolume,
                                          onChanged: (value) {
                                            // audioController.setVolume(value);
                                            _currentVolume = value;
                                            VolumeController.instance
                                                .setVolume(value);
                                          }),
                                    ),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              }),
                            ),
// updated
                            audioController.showAdhanTimesOnSide.value == true
                                ? Positioned(
                                    top: -10.h,
                                    child: Obx(
                                      () {
                                        final nextPrayer = controllerTwo
                                            .nextPrayer.value.capitalizeFirst;
                                        return Container(
                                          width: 60.w,
                                          height: 40.h,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5.5.w,
                                                ),
                                                DynamicTextWidget(
                                                    text:
                                                        // '${prayerTimeController.upComingPrayer}-${prayerTimeController.countdownTime}',
                                                        '${nextPrayer.toString().tr} ${controllerTwo.countdownText}',
                                                    fontSize: 4.5),
                                                SizedBox(
                                                  height: 20.h,
                                                  child: GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 5,
                                                      crossAxisSpacing: 10.0,
                                                      mainAxisSpacing: 10.0,
                                                    ),
                                                    itemCount: controllerTwo
                                                        .prayerTimes
                                                        .keys
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final key = controllerTwo
                                                          .prayerTimes.keys
                                                          .elementAt(index);
                                                      final time = controllerTwo
                                                          .prayerTimes.values
                                                          .elementAt(index);
                                                      // final time = controllerTwo.prayerTimes[index];
                                                      final prayerIndex =
                                                          index % 5;
                                                      final target = controllerTwo
                                                          .parsePrayerTime(
                                                              controllerTwo
                                                                      .prayerTimes[
                                                                  controllerTwo
                                                                      .nextPrayer
                                                                      .value]!,
                                                              controllerTwo
                                                                  .nextPrayer
                                                                  .value);
                                                      final baseTime =
                                                          controllerTwo
                                                                      .prayerTimes[
                                                                  key] ??
                                                              "";
                                                      final adjustedTime =
                                                          controllerTwo
                                                              .getAdjustedTime(
                                                                  baseTime,
                                                                  key);
                                                      return CirclePrayerTime(
                                                        prayerName:
                                                            "${key.capitalizeFirst}",
                                                        // prayerTime:
                                                        //     "${target}",
                                                        prayerTime:
                                                            "${adjustedTime}",
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 40.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      currentime,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 8.w,
                                            fontWeight: FontWeight.w100,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                // clockController
                                                //     .getCurrentDaySelectedTimeZone(),
                                                controllerTwo
                                                    .getCurrentDaySelectedTimeZone(),
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontSize: 3.w,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Text(
                                                // clockController
                                                //     .getCurrentDateInSelectedTimeZone(),
                                                controllerTwo
                                                    .getCurrentDateInSelectedTimeZone(),
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontSize: 3.w,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              // arabic calender date and year
                                              // Text(
                                              //   '${_today.toFormat("MMMM dd,  yyyy")}',
                                              //   style: GoogleFonts.roboto(
                                              //     textStyle: TextStyle(
                                              //         fontSize: 3.w,
                                              //         fontWeight:
                                              //             FontWeight.w200,
                                              //         color: Colors.white),
                                              //   ),
                                              // ),
                                              Obx(() => Text(
                                                    controllerTwo
                                                        .hijriDateFormatted
                                                        .toString()
                                                        .tr,
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        fontSize: 3.w,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // Expanded(
                              //   child: prayer_time_grid(
                              //       prayerTimeController: prayerTimeController),
                              // ),
                              //
                              audioController.showAdhanTimesOnSide.value ==
                                      false
                                  ? Obx(
                                      () {
                                        final nextPrayer = controllerTwo
                                            .nextPrayer.value.capitalizeFirst;
                                        return Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5.5.w,
                                                ),
                                                DynamicTextWidget(
                                                    text:
                                                        // '${prayerTimeController.upComingPrayer}-${prayerTimeController.countdownTime}',
                                                        '${nextPrayer.toString().tr} ${controllerTwo.countdownText}',
                                                    fontSize: 4.5),
                                                SizedBox(
                                                  height: 20.h,
                                                  child: GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 5,
                                                      crossAxisSpacing: 10.0,
                                                      mainAxisSpacing: 10.0,
                                                    ),
                                                    itemCount: controllerTwo
                                                        .prayerTimes
                                                        .keys
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final key = controllerTwo
                                                          .prayerTimes.keys
                                                          .elementAt(index);
                                                      final time = controllerTwo
                                                          .prayerTimes.values
                                                          .elementAt(index);
                                                      // final time = controllerTwo.prayerTimes[index];
                                                      final prayerIndex =
                                                          index % 5;
                                                      final target = controllerTwo
                                                          .parsePrayerTime(
                                                              controllerTwo
                                                                      .prayerTimes[
                                                                  controllerTwo
                                                                      .nextPrayer
                                                                      .value]!,
                                                              controllerTwo
                                                                  .nextPrayer
                                                                  .value);
                                                      final baseTime =
                                                          controllerTwo
                                                                      .prayerTimes[
                                                                  key] ??
                                                              "";
                                                      final adjustedTime =
                                                          controllerTwo
                                                              .getAdjustedTime(
                                                                  baseTime,
                                                                  key);
                                                      return CirclePrayerTime(
                                                        prayerName:
                                                            "${key.capitalizeFirst}",
                                                        // prayerTime:
                                                        //     "${target}",
                                                        prayerTime:
                                                            "${adjustedTime}",
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.w,
                        ),
                        Container(
                          height: 2.w,
                          width: 100.w,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90.w,
                              ),
                              Container(
                                height: .8.w,
                                width: 7.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/side_tag.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          // endDrawer: audioController.openAudioPlayer == true
          //     ? TransparentDrawer(context: context)
          //     : Transparent_drawer_settings_two(context: context),
          endDrawer: Obx(() {
            switch (audioController.activeDrawer.value) {
              case AppDrawerType.player:
                return TransparentDrawer(context: context);

              case AppDrawerType.settings:
                return Transparent_drawer_settings_two(context: context);

              case AppDrawerType.ruqya:
                return TransparentDrawerThree(context: context);

              default:
                return TransparentDrawer(context: context);
            }
          }),

          onEndDrawerChanged: (isOpen) {
            if (!isOpen) {
              // 🔔 Drawer closed
              //  audioController.toogleOpenAudioPlayer(false);
              audioController.toggleShowAdhanTimesOnSide(false);
            }
          },
        ),
      );
    });
  }

  CircleAvatar sideBar_child(String assetPath) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.black.withOpacity(.3),
      child: Image(
        image: AssetImage(
          assetPath,
        ),
        fit: BoxFit.contain,
        width: 20,
      ),
    );
  }

  Container surahText(String inputText) {
    return Container(
      width: 80.w,
      height: 8.w,
      child: Text(
        // 'hadia'.tr,
        inputText,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
              letterSpacing: .8,
              fontSize: 2.w,
              fontWeight: FontWeight.w300,
              color: Colors.white),
        ),
      ),
    );
  }
}
