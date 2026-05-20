import 'dart:async';
import 'dart:convert';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:muaddin/core/widgets/dynamic_text_widget.dart';

class PrayerTimeControllerFour extends GetxController {
  // need to upgrade hedia
  // for clock
  final RxBool isManualTimeEnabled = false.obs;
  final Rx<tz.TZDateTime?> manualDateTime = Rx<tz.TZDateTime?>(null);

  var currentTime = DateTime.now().obs;
  var selectedTimeZone = 'Europe/Amsterdam'.obs;

  var timezoneLocations = <String>[].obs;
  var isToogleClicked = false.obs;
  var currentTimeInSelectedTimezone = ''.obs;

  tz.TZDateTime get effectiveNow {
    if (isManualTimeEnabled.value && manualDateTime.value != null) {
      return manualDateTime.value!;
    }
    return getCurrentTime(selectedCountry.value.toLowerCase());
  }
// menual time function end

  void _fetchAllTimeZones() {
    timezoneLocations.assignAll(tz.timeZoneDatabase.locations.keys.toList());
    update();
  }
// could be better written
  void _startClock() {
    ever(currentTime, (_) => update());

    Timer.periodic(const Duration(seconds: 60), (_) {
      try {
        final location = tz.getLocation(selectedTimeZone.value);
        currentTime.value = tz.TZDateTime.now(location);
      } catch (e) {
        currentTime.value = DateTime.now().toLocal();
      }
    });
  }
// updated
  // String getCurrentTimeInSelectedTimeZone() {
  //   final location = tz.getLocation(selectedTimeZone.value);
  //   final tzTime = tz.TZDateTime.now(location);
  //   final formatter = DateFormat('HH:mm');
  //   return formatter.format(tzTime);
  // }

  // String getCurrentDateInSelectedTimeZone() {
  //   final location = tz.getLocation(selectedTimeZone.value);
  //   final tzTime = tz.TZDateTime.now(location);
  //   final formatter = DateFormat('MMMM d, yyyy', selectedLanguage.value);
  //   final formatted = formatter.format(tzTime);
  //   //  return formatted[0].toUpperCase() + formatted.substring(1);
  //   return formatter.format(tzTime);
  // }

  String getCurrentTimeInSelectedTimeZone() {
    final formatter = DateFormat('HH:mm');
    return formatter.format(effectiveNow);
  }

  String getCurrentDateInSelectedTimeZone() {
    final formatter = DateFormat('MMMM d, yyyy', selectedLanguage.value);
    return formatter.format(effectiveNow);
  }

  String getCurrentDaySelectedTimeZone() {
    final location = tz.getLocation(selectedTimeZone.value);
    final tzTime = tz.TZDateTime.now(location);
    final formatter = DateFormat('EEEE', selectedLanguage.value);
    return formatter.format(tzTime);
  }

  final selectedCity = 'Gouda'.obs;
  final selectedCountry = 'Netherlands'.obs;
  final RxBool isMuted = false.obs;
  // final adhanVoice = 'https://www.islamcan.com/audio/adhan/azan1.mp3'.obs;
  final adhanVoice =
      'https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin1.mp3?alt=media&token=8465b95c-b29f-4e7f-ba06-00ceab6dc51e'
          .obs;

  final RxMap<String, bool> prayerMuteStatus = <String, bool>{
    "fajr": false,
    "dhuhr": false,
    "asr": false,
    "maghrib": false,
    "isha": false,
  }.obs;

  final RxMap<String, String> prayerAdhanVoices = <String, String>{
    "fajr": 'https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin1.mp3?alt=media&token=8465b95c-b29f-4e7f-ba06-00ceab6dc51e',
    "dhuhr": 'https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin1.mp3?alt=media&token=8465b95c-b29f-4e7f-ba06-00ceab6dc51e',
    "asr": 'https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin1.mp3?alt=media&token=8465b95c-b29f-4e7f-ba06-00ceab6dc51e',
    "maghrib": 'https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin1.mp3?alt=media&token=8465b95c-b29f-4e7f-ba06-00ceab6dc51e',
    "isha": 'https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin1.mp3?alt=media&token=8465b95c-b29f-4e7f-ba06-00ceab6dc51e',
  }.obs;
  final RxList<String> states = <String>[
    'Gouda',
    'Amsterdam',
    'Rotterdam',
    'The Hague',
    'Utrecht',
    'Almere',
    'Groningen',
    'Eindhoven',
    'Breda',
    'Nijmegen',
    'Zaanstad',
    'Arnhem',
    'Haarlem',
    'Amersfoort',
    'Apeldoorn',
    'Leiden',
    'Zwolle',
    'Zoetermeer',
    'Maastricht',
    'Dordrecht',
    'Leeuwarden',
    'Alkmaar',
    'Emmen',
    'Hilversum',
    'Helmond',
    'Schiedam',
    'Lelystad',
    'Hoorn',
    'Vlaardingen',
    'Almelo',
    'Assen',
    'Delft',
    'Deventer',
    'Middelburg',
    'Harderwijk',
    'Zutphen',
    'Medemblik',
    'Wageningen',
    'Beverwijk',
    'Culemborg',
    'Maassluis',
    'Best',
    'Elburg',
    'Veere',
    'Enkhuizen',
    'Laren',
    'Sloten'
  ].obs;

  final Map<String, List<String>> countryCities = {
    // 🇳🇱 Netherlands
    'Netherlands': [
      'Berkel en Rodenrijs',
      'Gouda',
      'Amsterdam',
      'Rotterdam',
      'The Hague',
      'S-hertogenbosch',
      'Utrecht',
      'Spijkenisse',
      'Nootdorp',
      'Hoofddorp',
      'Eindhoven',
      'Groningen',
      'Houten',
      'Tilburg',
      'Almere',
      'Breda',
      'Nijmegen',
      'Enschede',
      'Haarlem',
      'Arnhem',
      'Zaanstad',
      'Amersfoort',
      'Apeldoorn',
      'Zwolle',
      'Zoetermeer',
      'Maastricht',
      'Leiden',
      'Dordrecht',
      'Ede',
      'Emmen',
      'Venlo',
      'Delft',
      'Deventer',
      'Alkmaar',
      'Sittard-Geleen',
      'Helmond',
      'Heerlen',
      'Hilversum',
      'Oss',
      'Schiedam',
      'Lelystad',
      'Hoorn',
      'Vlaardingen',
      'Almelo',
      'Assen',
      'Middelburg',
      'Harderwijk',
      'Zutphen',
      'Medemblik',
      'Wageningen',
      'Beverwijk',
      'Culemborg',
      'Maassluis',
      'Best',
      'Elburg',
      'Veere',
      'Enkhuizen',
      'Laren',
      'Sloten',

      // new
      'Vlissingen',
      'Alphen aan den Rijn',
      'Katwijk',
      'Purmerend',
      'Amstelveen',
      'Nieuwegein',
      'Zeist',
      'Veenendaal',
      'Roosendaal',
      'Bergen op Zoom',
      'Oosterhout',
      'Waalwijk',
      'Etten-Leur',
      'Weert',
      'Tiel',
      'Zaltbommel',
      'Ridderkerk',
      'Barendrecht',
      'Pijnacker',
      'Hellevoetsluis',
      'Noordwijk',
      'Kampen',
      'Meppel',
      'Drachten',
      'Hoogeveen',
      'Leeuwarden',
      'Terneuzen',
      'Goes',

      'Dronten',
      'Baarn'
    ],

    // 🇧🇪 Belgiummmmmmmmmmmmmm
    'Belgium': [
      'Brussels',
      'Antwerp',
      'Ghent',
      'Bruges',
      'Leuven',
      'Mechelen',
      'Hasselt',
      'Genk',
      'Kortrijk',
      'Ostend',
      'Roeselare',
      'Aalst',
      'Sint-Niklaas',
      'Turnhout',
      'Lier',
      'Tienen',
      'Namur',
      'Liège',
      'Charleroi',
      'Mons',
      'Tournai',
      'La Louvière',
      'Arlon',
    ],
    // need to add arabic, let's rapup production three
    // 🇫🇷 France
    'France': [
      'Paris',
      'Marseille',
      'Lyon',
      'Toulouse',
      'Nice',
      'Nantes',
      'Strasbourg',
      'Montpellier',
      'Bordeaux',
      'Lille',
      'Rennes',
      'Reims',
      'Le Havre',
      'Saint-Étienne',
      'Toulon',
      'Grenoble',
      'Dijon',
      'Angers',
      'Nîmes',
      'Clermont-Ferrand',
      'Tours',
      'Orléans',
      'Metz',
      'Nancy',
      'Mulhouse',
      'Colmar',
      'Amiens',
      'Besançon',
      'Annecy',
      'Chambéry',
      'Avignon',
      'Arles',
      'Cannes',
      'Antibes',
    ],

    // 🇩🇪 Germany
    'Germany': [
      'Berlin',
      'Hamburg',
      'Munich',
      'Cologne',
      'Frankfurt',
      'Stuttgart',
      'Düsseldorf',
      'Dortmund',
      'Essen',
      'Leipzig',
      'Bremen',
      'Dresden',
      'Hanover',
      'Nuremberg',
      'Duisburg',
      'Bochum',
      'Wuppertal',
      'Bielefeld',
      'Bonn',
      'Münster',
      'Karlsruhe',
      'Mannheim',
      'Freiburg',
      'Heidelberg',
      'Ulm',
      'Augsburg',
      'Regensburg',
      'Würzburg',
      'Ingolstadt',
      'Passau',
      'Landshut',
    ],
  };

  List<String> get countries => countryCities.keys.toList();

  // List<String> get cities => selectedCountry.value.isEmpty
  //     ? []
  //     : countryCities[selectedCountry.value]!;
  List<String> get cities {
    if (selectedCountry.value.isEmpty) return [];

    List<String> sortedCities =
        List.from(countryCities[selectedCountry.value] ?? []);

    sortedCities.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return sortedCities;
  }

  final selectedLanguage = 'nl'.obs;
  final timeRemaining = Duration.zero.obs;
  final nextPrayer = ''.obs;
  final currentPrayer = ''.obs;
  final prayerTimes = <String, String>{}.obs;
  late AudioPlayer _player;
  bool _playerReady = false;

  String? _lastPlayedPrayer;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _fetchAllTimeZones();
    _startClock();
    scheduleMidnightRefresh();
    tz.initializeTimeZones();
    _initPlayer();
    fetchPrayerTimes();
  }

  void _initPlayer() {
    _player = AudioPlayer(
      audioPipeline: AudioPipeline(
        androidAudioEffects: [
          AndroidLoudnessEnhancer(),
        ],
      ),
    );
    _playerReady = true;
  }

  void toggleMute() {
    isMuted.toggle();

    if (_playerReady) {
      _player.setVolume(isMuted.value ? 0.0 : 1.0);
    }
  }

  void togglePrayerMute(String prayer) {
    String p = prayer.toLowerCase();
    prayerMuteStatus[p] = !(prayerMuteStatus[p] ?? false);
    update();
  }

  void setPrayerAdhan(String prayer, String url) {
    prayerAdhanVoices[prayer.toLowerCase()] = url;
    update();
  }

  Future<void> changeMuadhin(String url) async {
    adhanVoice.value = url;
    // Also update all prayer voices to the selected one if we want a global change
    // but typically the user might want a global default.
    // For now, let's keep it global as well.
    for (var key in prayerAdhanVoices.keys) {
      prayerAdhanVoices[key] = url;
    }

    if (_playerReady) {
      await _player.stop();
      await _player.dispose();
    }

    _initPlayer();
    _lastPlayedPrayer = null;
  }

  Future<void> fetchPrayerTimes() async {
    // final now = DateTime.now();
    // final now = getCurrentTime(selectedCountry.value.toLowerCase());
    final now = effectiveNow;
    final url =
        "https://api.aladhan.com/v1/calendarByCity/${now.year}/${now.month}?city=${selectedCity.value}&country=${selectedCountry.value}&method=3&school=3";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final todayIndex = now.day - 1;
        final todayTimings = data['data'][todayIndex]['timings'];

        // normalize and clean (remove (CEST) etc.)
        final cleaned = <String, String>{};
        for (final key in ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"]) {
          String raw = todayTimings[key];
          raw = raw.split(" ").first; // remove timezone part
          cleaned[key.toLowerCase()] = raw;
        }

        // prayerTimes.assignAll(cleaned);

        prayerTimes.assignAll({
          "fajr": "07:17",
          "dhuhr": "07:19",
          "asr": "07:21",
          "maghrib": "07:23",
          "isha": "07:25",
        });
        print(
            'this is prayer time is the prayertime controller four ${prayerTimes}');
        updatePrayerStatus();
        startTimer();
      }
    } catch (e) {
      print("Error fetching prayer times: $e");
    }
  }
// helloooooooooooohhkjhkljhnkjlklk
  // tz.TZDateTime getCurrentTime() {
  //   final location = tz.getLocation('Europe/Amsterdam');
  //   return tz.TZDateTime.now(location);
  // }

  final Map<String, String> countryTimeZones = {
    'netherlands': 'Europe/Amsterdam',
    'germany': 'Europe/Berlin',
    'france': 'Europe/Paris',
    'belgium': 'Europe/Brussels',
  };

  tz.TZDateTime getCurrentTime(String country) {
    final timeZone = countryTimeZones[country.toLowerCase()];

    if (timeZone == null) {
      throw Exception('Timezone not found for country: $country');
    }

    final location = tz.getLocation(timeZone);
    return tz.TZDateTime.now(location);
  }

  final adjustments = {
    "fajr": 0,
    "dhuhr": 0,
    "asr": 0,
    "maghrib": 0,
    "isha": 0,
  }.obs;

  String getAdjustedTime(String time, String prayer) {
    try {
      final adj = adjustments[prayer.toLowerCase()] ?? 0;
      final parsed = DateFormat("HH:mm").parse(time);
      final adjusted = parsed.add(Duration(minutes: adj));
      return DateFormat("HH:mm").format(adjusted);
    } catch (e) {
      return time;
    }
  }

  tz.TZDateTime parsePrayerTime(String time, String prayer) {
    // final now = getCurrentTime(selectedCountry.value.toLowerCase());
    final now = effectiveNow;
    final parts = time.split(":");

    return tz.TZDateTime(
      tz.getLocation('Europe/Amsterdam'),
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    ).add(
      Duration(minutes: adjustments[prayer] ?? 0),
    );
  }

  late tz.TZDateTime _nextPrayerDateTime;
  late tz.TZDateTime _ZNextPrayerTime;

  void updatePrayerStatus() {
    if (prayerTimes.isEmpty) return;

    // final now = getCurrentTime(selectedCountry.value.toLowerCase());
    final now = effectiveNow;
    final order = ["fajr", "dhuhr", "asr", "maghrib", "isha"];

    for (final p in order) {
      final t = parsePrayerTime(prayerTimes[p]!, p);
      if (t.isAfter(now)) {
        nextPrayer.value = p;
        _ZNextPrayerTime = t;
        return;
      }
    }

    // After Isha → tomorrow Fajr
    nextPrayer.value = "fajr";
    _ZNextPrayerTime = parsePrayerTime(
      prayerTimes["fajr"]!,
      "fajr",
    ).add(const Duration(days: 1));
  }

  // void startTimer() {
  //   _timer?.cancel();
  //   _timer = Timer.periodic(const Duration(seconds: 1), (_) {
  //     final now = getCurrentTime(selectedCountry.value.toLowerCase());
  //     final diff = _ZNextPrayerTime.difference(now);

  //     timeRemaining.value = diff;

  //     if (diff.inSeconds <= 0 && _lastPlayedPrayer != nextPrayer.value) {
  //       _lastPlayedPrayer = nextPrayer.value;
  //       _playAdhan();

  //       // 🚨 FORCE MOVE TO NEXT PRAYER
  //       _forceNextPrayer();
  //     }
  //   });
  // }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isManualTimeEnabled.value && manualDateTime.value != null) {
        manualDateTime.value =
            manualDateTime.value!.add(const Duration(seconds: 1));
      }

      final now = effectiveNow;
      final diff = _ZNextPrayerTime.difference(now);

      timeRemaining.value = diff.isNegative ? Duration.zero : diff;

      if (diff.inSeconds <= 0 && _lastPlayedPrayer != nextPrayer.value) {
        _lastPlayedPrayer = nextPrayer.value;
        _playAdhan();
        Future.delayed(const Duration(seconds: 2), updatePrayerStatus);
      }
    });
  }

  void _forceNextPrayer() {
    final order = ["fajr", "dhuhr", "asr", "maghrib", "isha"];
    final currentIndex = order.indexOf(nextPrayer.value);

    if (currentIndex < order.length - 1) {
      nextPrayer.value = order[currentIndex + 1];
      _ZNextPrayerTime = parsePrayerTime(
        prayerTimes[nextPrayer.value]!,
        nextPrayer.value,
      );
    } else {
      // Isha → tomorrow Fajr
      nextPrayer.value = "fajr";
      _ZNextPrayerTime = parsePrayerTime(
        prayerTimes["fajr"]!,
        "fajr",
      ).add(const Duration(days: 1));
    }
  }

  void scheduleMidnightRefresh() {
    final now = getCurrentTime(selectedCountry.value.toLowerCase());
    final tomorrow = tz.TZDateTime(
      tz.getLocation('Europe/Amsterdam'),
      now.year,
      now.month,
      now.day + 1,
    );
// this need to be change to the selected country time zone
    Timer(tomorrow.difference(now), () {
      fetchPrayerTimes();
      scheduleMidnightRefresh();
    });
  }

  void _showAdhanPopup(String prayer) {
    printInfo(info: 'into show pop up');
    if (Get.isDialogOpen == true) return;

    Get.dialog(
      WillPopScope(
        onWillPop: () async => false, // prevent back button
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Container(
            width: 85.w,
            height: 80.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/popup.jpeg'))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 1.5.w,
                ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 7.w,
                //     ),
                //     Obx(() => GestureDetector(
                //           onTap: toggleMute,
                //           child: Icon(
                //             isMuted.value ? Icons.volume_off : Icons.volume_up,
                //             size: 42,
                //             color: Colors.black,
                //           ),
                //         )),
                //     SizedBox(
                //       width: 2.w,
                //     ),
                //     GestureDetector(
                //       onTap: () => Get.back(),
                //       child: const Icon(
                //         Icons.cancel,
                //         size: 48,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 16),
                DynamicTextWidget(
                  text: 'calling_adhan'.tr,
                  // text: '${prayer.toLowerCase()}_title'.tr,
                  fontSize: 5,
                  inputWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 25.w,
                ),
                DynamicTextWidget(
                  // text: "${prayer.toLowerCase()}_text".tr,
                  text: "${'time_for'.tr} ${prayer.capitalizeFirst!.toString().tr}",
                  fontSize: 3.3,
                  inputWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                const SizedBox(height: 6),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 38.w,
                    ),
                    Obx(() => GestureDetector(
                          onTap: toggleMute,
                          child: Icon(
                            isMuted.value ? Icons.volume_off : Icons.volume_up,
                            size: 42,
                            color: Colors.black,
                          ),
                        )),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.cancel,
                        size: 48,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _closeAdhanPopup() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  Future<void> _playAdhan() async {
    try {
      if (_playerReady) {
        await _player.stop();
        await _player.dispose();
      }

      _initPlayer();

      _showAdhanPopup(nextPrayer.value);

      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _closeAdhanPopup();
        }
      });

      String currentPrayer = nextPrayer.value.toLowerCase();
      String voiceUrl = prayerAdhanVoices[currentPrayer] ?? adhanVoice.value;
      bool currentMuted = isMuted.value || (prayerMuteStatus[currentPrayer] ?? false);

      await _player.setUrl(voiceUrl);
      await _player.setVolume(currentMuted ? 0.0 : 1.0);
      await _player.play();
    } catch (e) {
      print("Error playing Adhan: $e");
      // _closeAdhanPopup();
    }
  }

  String get countdownText {
    final d = timeRemaining.value;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    return "${h.toString().padLeft(2, '0')}:"
        "${m.toString().padLeft(2, '0')}:"
        "${s.toString().padLeft(2, '0')}";
  }

  void increasePrayerTime(String prayer) {
    adjustments[prayer] = (adjustments[prayer] ?? 0) + 1;
    updatePrayerStatus();
    update();
  }

  void decreasePrayerTime(String prayer) {
    adjustments[prayer] = (adjustments[prayer] ?? 0) - 1;
    print('Decreaseeeeeee');
    updatePrayerStatus();
  }

  HijriCalendar get hijriToday {
    final now = effectiveNow;

    return HijriCalendar.fromDate(
      DateTime(now.year, now.month, now.day),
    );
  }

  String get hijriDateFormatted {
    return hijriToday.toFormat("MMMM dd, yyyy");
  }

  @override
  void onClose() {
    _timer?.cancel();
    _player.dispose();
    super.onClose();
  }
}
