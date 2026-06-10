import 'dart:convert';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muaddin/features/player_two/repository/model/moshaf_model.dart';
import 'package:muaddin/features/player_two/repository/model/reciter_model.dart';
import 'package:http/http.dart' as http;
import 'package:muaddin/features/player_two/controller/audio_controller.dart';

class AudioControllerTwo extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer(
    audioPipeline: AudioPipeline(
      androidAudioEffects: [
        AndroidLoudnessEnhancer(),
      ],
    ),
  );
  var isRukyaMode = true.obs;
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;
  var isPlaying = false.obs;
  var isMuted = false.obs;
  var volume = 1.0.obs;
  var isVolumeSliderVisible = false.obs;
  var suraIndex = 0.obs;
  var rukyaIndex = 0.obs;
  var adhanIndex = 0.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  var openAudioPlayer = false.obs;
  var showAdhanTimesOnSide = false.obs;
  var isHadia = false.obs;
  var reciters = <Reciter>[].obs;
  var selectedReciter = Rxn<Reciter>();
  var selectedMoshaf = Rxn<Moshaf>();
  var autoNextSurahEnabled = true.obs;

  final List<String> surahNames = [
    "Al-Fatihah",
    "Al-Baqarah",
    "Al-Imran",
    "An-Nisa",
    "Al-Ma'idah",
    "Al-An'am",
    "Al-A'raf",
    "Al-Anfal",
    "At-Tawbah",
    "Yunus",
    "Hud",
    "Yusuf",
    "Ar-Ra'd",
    "Ibrahim",
    "Al-Hijr",
    "An-Nahl",
    "Al-Isra",
    "Al-Kahf",
    "Maryam",
    "Taha",
    "Al-Anbiya",
    "Al-Hajj",
    "Al-Mu'minun",
    "An-Nur",
    "Al-Furqan",
    "Ash-Shu'ara",
    "An-Naml",
    "Al-Qasas",
    "Al-Ankabut",
    "Ar-Rum",
    "Luqman",
    "As-Sajdah",
    "Al-Ahzab",
    "Saba",
    "Fatir",
    "Yasin",
    "As-Saffat",
    "Sad",
    "Az-Zumar",
    "Ghafir",
    "Fussilat",
    "Ash-Shura",
    "Az-Zukhruf",
    "Ad-Dukhan",
    "Al-Jathiyah",
    "Al-Ahqaf",
    "Muhammad",
    "Al-Fath",
    "Al-Hujurat",
    "Qaf",
    "Adh-Dhariyat",
    "At-Tur",
    "An-Najm",
    "Al-Qamar",
    "Ar-Rahman",
    "Al-Waqi'ah",
    "Al-Hadid",
    "Al-Mujadilah",
    "Al-Hashr",
    "Al-Mumtahanah",
    "As-Saff",
    "Al-Jumu'ah",
    "Al-Munafiqun",
    "At-Taghabun",
    "At-Talaq",
    "At-Tahrim",
    "Al-Mulk",
    "Al-Qalam",
    "Al-Haqqah",
    "Al-Ma'arij",
    "Nuh",
    "Al-Jinn",
    "Al-Muzzammil",
    "Al-Muddathir",
    "Al-Qiyamah",
    "Al-Insan",
    "Al-Mursalat",
    "An-Naba",
    "An-Nazi'at",
    "Abasa",
    "At-Takwir",
    "Al-Infitar",
    "Al-Mutaffifin",
    "Al-Inshiqaq",
    "Al-Buruj",
    "At-Tariq",
    "Al-A'la",
    "Al-Ghashiyah",
    "Al-Fajr",
    "Al-Balad",
    "Ash-Shams",
    "Al-Layl",
    "Ad-Duhaa",
    "Ash-Sharh",
    "At-Tin",
    "Al-'Alaq",
    "Al-Qadr",
    "Al-Bayyinah",
    "Az-Zalzalah",
    "Al-Adiyat",
    "Al-Qari'ah",
    "At-Takathur",
    "Al-Asr",
    "Al-Humazah",
    "Al-Fil",
    "Quraish",
    "Al-Ma'un",
    "Al-Kawthar",
    "Al-Kafirun",
    "An-Nasr",
    "Al-Masad",
    "Al-Ikhlas",
    "Al-Falaq",
    "An-Nas"
  ];
  final List<String> muajjinName = [
    "Muadhin One",
    "Muadhin Two",
    "Muadhin Three",
    "Muadhin Four",
    "Muadhin Five",
    "Muadhin Six",
    "Muadhin Seven",
    "Muadhin Eight",
    "Muadhin Nine",
    "Muadhin Ten",
    "Muadhin Eleven",
    "Muadhin Twelve",
    "Muadhin Thirteen",
    "Muadhin Fourteen",
    "Muadhin Fifteen",
    "Muadhin Sixteen",
    "Muadhin Seventeen",
    "Muadhin Eighteen",
    "Muadhin Nineteen",
    "Muadhin Twenty",
    "Muadhin Twenty one",
  ];

  final List<String> adhanUrl = [
    'https://www.islamcan.com/audio/adhan/azan1.mp3',
    'https://www.islamcan.com/audio/adhan/azan2.mp3',
    'https://www.islamcan.com/audio/adhan/azan3.mp3',
    'https://www.islamcan.com/audio/adhan/azan4.mp3',
    'https://www.islamcan.com/audio/adhan/azan5.mp3',
    'https://www.islamcan.com/audio/adhan/azan6.mp3',
    'https://www.islamcan.com/audio/adhan/azan7.mp3',
    'https://www.islamcan.com/audio/adhan/azan8.mp3',
    'https://www.islamcan.com/audio/adhan/azan9.mp3',
    'https://www.islamcan.com/audio/adhan/azan10.mp3',
    'https://www.islamcan.com/audio/adhan/azan11.mp3',
    'https://www.islamcan.com/audio/adhan/azan12.mp3',
    'https://www.islamcan.com/audio/adhan/azan13.mp3',
    'https://www.islamcan.com/audio/adhan/azan14.mp3',
    'https://www.islamcan.com/audio/adhan/azan15.mp3',
    'https://www.islamcan.com/audio/adhan/azan16.mp3',
    'https://www.islamcan.com/audio/adhan/azan17.mp3',
    'https://www.islamcan.com/audio/adhan/azan18.mp3',
    'https://www.islamcan.com/audio/adhan/azan19.mp3',
    'https://www.islamcan.com/audio/adhan/azan20.mp3',
    'https://www.islamcan.com/audio/adhan/azan21.mp3',
  ];

  final List<String> rukyaNames = [
    "surahAlBaqarah",
    "generalRuqya",
    "evilEye",
    "blackMagic",
    "knowledge",
    "advice",
    "burning",
    "healing",
    "zina",
    "summarisedRuqya",
    "divorce",
    "destruction",
    "falaqNaas",
    "ayatKursi",
    "salawat",
    "jews",
    "christians",
    "saaffat",
    "jinn",
    "yaseen",
    "birds",
    "rizq",
    "mountains",
    "guidance",
    "hairLoss",
    "fatihah",
    "lastTwoAyat",
    "beginningSaaffat",
    "planetsStars",
    "seaVerses",
    "graveVerses",
    "breastCancer",
    "walkingIssues",
  ];

  final List<String> rukyaUrls = [
    "https://www.ruqyainlondon.com/files/ruqya/baqara.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/roqya.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/eyehasd.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/sihr.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/alelm.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/nasiha.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/harq.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/shifa.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/zina.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/mokhtsra.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/talaq.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/tadmer.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/falaqnas.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/kursi.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/salat.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/yahod.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/nasara.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/safat.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/jin.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/yaseen-.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/bird.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/RIZQ.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/jibal.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/hidaya.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/shaar.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/fatha.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/aaman.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/10saft.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/stars.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/sea.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/graves.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/canser.mp3",
    "https://www.ruqyainlondon.com/files/ruqya/walking.mp3",
  ];

  final List<String> duaName = [
    "Mishary Alafasi",
    "Idriss Abkar",
    "Walid Atef",
    "Ahmed abdul Rahman darar",
    "Muhammad jebril",
    "Rami Aldeais",
    "Nasser Alqatami",
    "Majed Al-Zamil",
    "Abdulbari Athobaity",
    "Abdulrahman Assudais",
    "Adel Rayan",
    "Maher Al-Mueaqly",
    "Tawfeeq As-Sayegh",
    "Muhammad Al-Muhasny",
    "Hani Arrifai"
  ];
  final List<String> duaUrls = [
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d08.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d01.mp3",
    "https://download.tvquran.com/download/selections/376/60880973067af.mp3",
    "https://download.tvquran.com/download/selections/380/608808c85d2b8.mp3",
    "https://download.tvquran.com/download/selections/180/5eb1a36e3399f.mp3",
    "https://download.tvquran.com/download/selections/248/5a0dd61719050.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d13.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d11.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d10.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d09.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d06.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d05.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d04.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d03.mp3",
    "https://download.tvquran.com/download/TvQuran.com__Doaa/TvQuran.com__d02.mp3"
  ];
  List<String> get currentTitles => isRukyaMode.value ? rukyaNames : duaName;

  int get currentItemCount =>
      isRukyaMode.value ? rukyaNames.length : duaName.length;

  @override
  void onInit() {
    super.onInit();

    fetchReciters().then((_) {
      if (reciters.isNotEmpty) {
        selectedReciter.value = reciters.first;
        selectedMoshaf.value = reciters.first.moshaf.first;
      }
    });

    // audioPlayer.durationStream.listen((position) {
    //   currentPosition.value = position ?? Duration.zero;
    // });

    // audioPlayer.durationStream.listen((duration) {
    //   if (duration != null) {
    //     totalDuration.value = duration;
    //   }
    // });

    // ✅ CURRENT POSITION
    audioPlayer.positionStream.listen((pos) {
      position.value = pos;
      currentPosition.value = pos;
    });

    // ✅ TOTAL DURATION
    audioPlayer.durationStream.listen((dur) {
      if (dur != null) {
        duration.value = dur;
        totalDuration.value = dur;
      }
    });

    // ✅ PLAY / PAUSE STATE
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (autoNextSurahEnabled.value && suraIndex.value != -1) {
          playNextSurah();
        }
      }
    });

    audioPlayer.playingStream.listen((playing) {
      if (playing) {
        try {
          if (Get.isRegistered<AudioController>()) {
            final other = Get.find<AudioController>();
            if (other.isPlaying.value) {
              other.pauseAudio();
            }
          }
        } catch (e) {
          print("Error pausing other player: $e");
        }
      }
    });
  }

  void playNextSurah() {
    final nextIndex = suraIndex.value + 1;

    // Stop if last surah
    if (nextIndex >= surahNames.length) {
      isPlaying.value = false;
      return;
    }

    playSurah(nextIndex);
  }

// alphabetical
  Future<void> fetchReciters() async {
    final res = await http.get(
      Uri.parse('https://www.mp3quran.net/api/v3/reciters?language=eng'),
    );

    final data = jsonDecode(res.body);

    final allReciters =
        (data['reciters'] as List).map((e) => Reciter.fromJson(e)).toList();

    // Filter reciters whose FIRST moshaf has 114 surahs
    final filtered = allReciters
        .where((reciter) =>
            reciter.moshaf.isNotEmpty &&
            reciter.moshaf.first.surahList.length == 114)
        .toList();

    // 🔠 Sort alphabetically by name
    filtered
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    reciters.value = filtered;

    // Set default selection
    if (reciters.isNotEmpty) {
      selectedReciter.value = reciters.first;
      selectedMoshaf.value = reciters.first.moshaf.first;
    }
  }
// alphabetical

// 114-----------------

  void toogleOpenAudioPlayer(bool value) {
    openAudioPlayer.value = value;
  }

  void toggleShowAdhanTimesOnSide(bool value) {
    showAdhanTimesOnSide.value = value;
  }

  Future<void> playSurah(int index) async {
    final surahNumber = index + 1;

    if (!selectedMoshaf.value!.surahList.contains(surahNumber)) {
      Get.snackbar(
          'Unavailable', 'This surah is not available for this reciter');
      return;
    }

    final url = buildSurahUrl(surahNumber);

    await audioPlayer.setUrl(url);
    await audioPlayer.play();

    suraIndex.value = index;
    isPlaying.value = true;
  }

  Future<void> playRukya(int index) async {
    final rukyaNumber = index + 1;

    if (rukyaUrls.contains(rukyaNumber)) {
      Get.snackbar(
          'Unavailable', 'This surah is not available for this reciter');
      return;
    }

    // final url = buildSurahUrl(rukyaNumber);
    final url = rukyaUrls[index];

    await audioPlayer.setUrl(url);
    await audioPlayer.play();

    suraIndex.value = index;
    isPlaying.value = true;
  }

  Future<void> playDua(int index) async {
    final url = duaUrls[index];

    await audioPlayer.setUrl(url);
    await audioPlayer.play();

    rukyaIndex.value = index; // reuse index for header display
    isPlaying.value = true;
  }

  String buildSurahUrl(int surahNumber) {
    final moshaf = selectedMoshaf.value!;
    final padded = surahNumber.toString().padLeft(3, '0');
    return '${moshaf.server}$padded.mp3';
  }

  void playAdhan(int index) {
    try {
      // audioPlayer.setUrl(adhanUrl[index]);
      playAudio();
    } catch (e) {}
  }

  void playAudio() async {
    await audioPlayer.play();
    isPlaying.value = true;
    // audioPlayer.positionStream.listen((event) {
    //   position.value = event;
    // });

    // audioPlayer.durationStream.listen((newDuration) {
    //   if (newDuration != null) duration.value = newDuration;
    // });
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  void skipForward() {
    final newPosition = position.value + Duration(seconds: 10);
    audioPlayer
        .seek(newPosition < duration.value ? newPosition : duration.value);
  }

  void skipBackward() {
    final newPositon = position.value - Duration(seconds: 10);
    audioPlayer.seek(newPositon < duration.value ? newPositon : duration.value);
  }

  void stopAudio() async {
    await audioPlayer.stop();
    isPlaying.value = false;
    position.value = Duration.zero;
  }

  void toogleMute() {
    isMuted.value = !isMuted.value;
    audioPlayer.setVolume(isMuted.value ? 0.0 : 1.0);
  }

  void seekAudio(double seconds) {
    final newPosition = Duration(seconds: seconds.toInt());
    audioPlayer.seek(newPosition);
    position.value = newPosition;
  }

  void setVolume(double newVolume) {
    volume.value = newVolume;
    audioPlayer.setVolume(newVolume);
  }

  void toggleVolumeSlider() {
    isVolumeSliderVisible.value = !isVolumeSliderVisible.value;
  }

  Future<void> stopAllAudio() async {
    await audioPlayer.stop();
    await audioPlayer.dispose();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
