import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

enum AppDrawerType {
  player,
  settings,
  ruqya,
}

class AudioController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer(
    audioPipeline: AudioPipeline(
      androidAudioEffects: [
        AndroidLoudnessEnhancer(),
      ],
    ),
  );
  var activeDrawer = AppDrawerType.player.obs;

  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;
  var isPlaying = false.obs;
  var isMuted = false.obs;
  var volume = 1.0.obs;
  var isVolumeSliderVisible = false.obs;
  var suraIndex = 0.obs;
  var adhanIndex = 0.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  var openAudioPlayer = false.obs;
  var showAdhanTimesOnSide = false.obs;
  var isHadia = false.obs;

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

  final List<String> surahUrls = [
    "https://server8.mp3quran.net/afs/001.mp3", // Al-Fatihah
    "https://server8.mp3quran.net/afs/002.mp3", // Al-Baqarah
    "https://server8.mp3quran.net/afs/003.mp3", // Al-Imran
    "https://server8.mp3quran.net/afs/004.mp3", // An-Nisa
    "https://server8.mp3quran.net/afs/005.mp3", // Al-Ma'idah
    "https://server8.mp3quran.net/afs/006.mp3", // Al-An'am
    "https://server8.mp3quran.net/afs/007.mp3", // Al-A'raf
    "https://server8.mp3quran.net/afs/008.mp3", // Al-Anfal
    "https://server8.mp3quran.net/afs/009.mp3", // At-Tawbah
    "https://server8.mp3quran.net/afs/010.mp3", // Yunus
    "https://server8.mp3quran.net/afs/011.mp3", // Hud
    "https://server8.mp3quran.net/afs/012.mp3", // Yusuf
    "https://server8.mp3quran.net/afs/013.mp3", // Ar-Ra'd
    "https://server8.mp3quran.net/afs/014.mp3", // Ibrahim
    "https://server8.mp3quran.net/afs/015.mp3", // Al-Hijr
    "https://server8.mp3quran.net/afs/016.mp3", // An-Nahl
    "https://server8.mp3quran.net/afs/017.mp3", // Al-Isra
    "https://server8.mp3quran.net/afs/018.mp3", // Al-Kahf
    "https://server8.mp3quran.net/afs/019.mp3", // Maryam
    "https://server8.mp3quran.net/afs/020.mp3", // Taha
    "https://server8.mp3quran.net/afs/021.mp3", // Al-Anbiya
    "https://server8.mp3quran.net/afs/022.mp3", // Al-Hajj
    "https://server8.mp3quran.net/afs/023.mp3", // Al-Mu'minun
    "https://server8.mp3quran.net/afs/024.mp3", // An-Nur
    "https://server8.mp3quran.net/afs/025.mp3", // Al-Furqan
    "https://server8.mp3quran.net/afs/026.mp3", // Ash-Shu'ara
    "https://server8.mp3quran.net/afs/027.mp3", // An-Naml
    "https://server8.mp3quran.net/afs/028.mp3", // Al-Qasas
    "https://server8.mp3quran.net/afs/029.mp3", // Al-Ankabut
    "https://server8.mp3quran.net/afs/030.mp3", // Ar-Rum
    "https://server8.mp3quran.net/afs/031.mp3", // Luqman
    "https://server8.mp3quran.net/afs/032.mp3", // As-Sajdah
    "https://server8.mp3quran.net/afs/033.mp3", // Al-Ahzab
    "https://server8.mp3quran.net/afs/034.mp3", // Saba
    "https://server8.mp3quran.net/afs/035.mp3", // Fatir
    "https://server8.mp3quran.net/afs/036.mp3", // Yasin
    "https://server8.mp3quran.net/afs/037.mp3", // As-Saffat
    "https://server8.mp3quran.net/afs/038.mp3", // Sad
    "https://server8.mp3quran.net/afs/039.mp3", // Az-Zumar
    "https://server8.mp3quran.net/afs/040.mp3", // Ghafir
    "https://server8.mp3quran.net/afs/041.mp3", // Fussilat
    "https://server8.mp3quran.net/afs/042.mp3", // Ash-Shura
    "https://server8.mp3quran.net/afs/043.mp3", // Az-Zukhruf
    "https://server8.mp3quran.net/afs/044.mp3", // Ad-Dukhan
    "https://server8.mp3quran.net/afs/045.mp3", // Al-Jathiyah
    "https://server8.mp3quran.net/afs/046.mp3", // Al-Ahqaf
    "https://server8.mp3quran.net/afs/047.mp3", // Muhammad
    "https://server8.mp3quran.net/afs/048.mp3", // Al-Fath
    "https://server8.mp3quran.net/afs/049.mp3", // Al-Hujurat
    "https://server8.mp3quran.net/afs/050.mp3", // Qaf
    "https://server8.mp3quran.net/afs/051.mp3", // Adh-Dhariyat
    "https://server8.mp3quran.net/afs/052.mp3", // At-Tur
    "https://server8.mp3quran.net/afs/053.mp3", // An-Najm
    "https://server8.mp3quran.net/afs/054.mp3", // Al-Qamar
    "https://server8.mp3quran.net/afs/055.mp3", // Ar-Rahman
    "https://server8.mp3quran.net/afs/056.mp3", // Al-Waqi'ah
    "https://server8.mp3quran.net/afs/057.mp3", // Al-Hadid
    "https://server8.mp3quran.net/afs/058.mp3", // Al-Mujadilah
    "https://server8.mp3quran.net/afs/059.mp3", // Al-Hashr
    "https://server8.mp3quran.net/afs/060.mp3", // Al-Mumtahanah
    "https://server8.mp3quran.net/afs/061.mp3", // As-Saff
    "https://server8.mp3quran.net/afs/062.mp3", // Al-Jumu'ah
    "https://server8.mp3quran.net/afs/063.mp3", // Al-Munafiqun
    "https://server8.mp3quran.net/afs/064.mp3", // At-Taghabun
    "https://server8.mp3quran.net/afs/065.mp3", // At-Talaq
    "https://server8.mp3quran.net/afs/066.mp3", // At-Tahrim
    "https://server8.mp3quran.net/afs/067.mp3", // Al-Mulk
    "https://server8.mp3quran.net/afs/068.mp3", // Al-Qalam
    "https://server8.mp3quran.net/afs/069.mp3", // Al-Haqqah
    "https://server8.mp3quran.net/afs/070.mp3", // Al-Ma'arij
    "https://server8.mp3quran.net/afs/071.mp3", // Nuh
    "https://server8.mp3quran.net/afs/072.mp3", // Al-Jinn
    "https://server8.mp3quran.net/afs/073.mp3", // Al-Muzzammil
    "https://server8.mp3quran.net/afs/074.mp3", // Al-Muddathir
    "https://server8.mp3quran.net/afs/075.mp3", // Al-Qiyamah
    "https://server8.mp3quran.net/afs/076.mp3", // Al-Insan
    "https://server8.mp3quran.net/afs/077.mp3", // Al-Mursalat
    "https://server8.mp3quran.net/afs/078.mp3", // An-Naba
    "https://server8.mp3quran.net/afs/079.mp3", // An-Nazi'at
    "https://server8.mp3quran.net/afs/080.mp3", // Abasa
    "https://server8.mp3quran.net/afs/081.mp3", // At-Takwir
    "https://server8.mp3quran.net/afs/082.mp3", // Al-Infitar
    "https://server8.mp3quran.net/afs/083.mp3", // Al-Mutaffifin
    "https://server8.mp3quran.net/afs/084.mp3", // Al-Inshiqaq
    "https://server8.mp3quran.net/afs/085.mp3", // Al-Buruj
    "https://server8.mp3quran.net/afs/086.mp3", // At-Tariq
    "https://server8.mp3quran.net/afs/087.mp3", // Al-A'la
    "https://server8.mp3quran.net/afs/088.mp3", // Al-Ghashiyah
    "https://server8.mp3quran.net/afs/089.mp3", // Al-Fajr
    "https://server8.mp3quran.net/afs/090.mp3", // Al-Balad
    "https://server8.mp3quran.net/afs/091.mp3", // Ash-Shams
    "https://server8.mp3quran.net/afs/092.mp3", // Al-Layl
    "https://server8.mp3quran.net/afs/093.mp3", // Ad-Duhaa
    "https://server8.mp3quran.net/afs/094.mp3", // Ash-Sharh
    "https://server8.mp3quran.net/afs/095.mp3", // At-Tin
    "https://server8.mp3quran.net/afs/096.mp3", // Al-'Alaq
    "https://server8.mp3quran.net/afs/097.mp3", // Al-Qadr
    "https://server8.mp3quran.net/afs/098.mp3", // Al-Bayyinah
    "https://server8.mp3quran.net/afs/099.mp3", // Az-Zalzalah
    "https://server8.mp3quran.net/afs/100.mp3", // Al-Adiyat
    "https://server8.mp3quran.net/afs/101.mp3", // Al-Qari'ah
    "https://server8.mp3quran.net/afs/102.mp3", // At-Takathur
    "https://server8.mp3quran.net/afs/103.mp3", // Al-Asr
    "https://server8.mp3quran.net/afs/104.mp3", // Al-Humazah
    "https://server8.mp3quran.net/afs/105.mp3", // Al-Fil
    "https://server8.mp3quran.net/afs/106.mp3", // Quraish
    "https://server8.mp3quran.net/afs/107.mp3", // Al-Ma'un
    "https://server8.mp3quran.net/afs/108.mp3", // Al-Kawthar
    "https://server8.mp3quran.net/afs/109.mp3", // Al-Kafirun
    "https://server8.mp3quran.net/afs/110.mp3", // An-Nasr
    "https://server8.mp3quran.net/afs/111.mp3", // Al-Masad
    "https://server8.mp3quran.net/afs/112.mp3", // Al-Ikhlas
    "https://server8.mp3quran.net/afs/113.mp3", // Al-Falaq
    "https://server8.mp3quran.net/afs/114.mp3", // An-Nas
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
    // need to be deleted 11 13 21
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
    "Muadhin Twenty Two",
  ];

  final List<String> adhanUrl = [
    // new four
    "https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin1.mp3?alt=media&token=8465b95c-b29f-4e7f-ba06-00ceab6dc51e",
    "https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin2.mp3?alt=media&token=fb048c40-6006-45bd-af63-3d5d6e8ca33b",
    "https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin3.mp3?alt=media&token=8d4f4952-bed1-4cda-9153-ed6a4ccfd574",
    "https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin4.mp3?alt=media&token=f82ede38-366f-4e51-89a8-df86a6a91d12",
    //
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
    //'https://www.islamcan.com/audio/adhan/azan11.mp3',
    'https://www.islamcan.com/audio/adhan/azan12.mp3',
    // 'https://www.islamcan.com/audio/adhan/azan13.mp3',
    'https://www.islamcan.com/audio/adhan/azan14.mp3',
    'https://www.islamcan.com/audio/adhan/azan15.mp3',
    'https://www.islamcan.com/audio/adhan/azan16.mp3',
    'https://www.islamcan.com/audio/adhan/azan17.mp3',
    'https://www.islamcan.com/audio/adhan/azan18.mp3',
    'https://www.islamcan.com/audio/adhan/azan19.mp3',
    'https://www.islamcan.com/audio/adhan/azan20.mp3',
    // 'https://www.islamcan.com/audio/adhan/azan21.mp3',
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
    // new four
    "https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin1.mp3?alt=media&token=8465b95c-b29f-4e7f-ba06-00ceab6dc51e",
    "https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin2.mp3?alt=media&token=fb048c40-6006-45bd-af63-3d5d6e8ca33b",
    "https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin3.mp3?alt=media&token=8d4f4952-bed1-4cda-9153-ed6a4ccfd574",
    "https://firebasestorage.googleapis.com/v0/b/muadhin-a26a0.firebasestorage.app/o/adhan_audio%2Fmuadhin4.mp3?alt=media&token=f82ede38-366f-4e51-89a8-df86a6a91d12",
    //

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

  @override
  void onInit() {
    super.onInit();

    audioPlayer.durationStream.listen((position) {
      currentPosition.value = position ?? Duration.zero;
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration;
      }
    });
  }

  void toogleOpenAudioPlayer(bool value) {
    openAudioPlayer.value = value;
  }

  void toggleShowAdhanTimesOnSide(bool value) {
    showAdhanTimesOnSide.value = value;
  }

  void playSurah(int index) {
    try {
      audioPlayer.setUrl(surahUrls[index]);
      // audioPlayer.setUrl('https://www.islamcan.com/audio/adhan/azan1.mp3');
      duration.value = audioPlayer.duration ?? Duration.zero;
      playAudio();
    } catch (e) {
      print("error loading surah: ${e}");
    }
  }

  void playAdhan(int index) {
    try {
      audioPlayer.setUrl(adhanUrl[index]);
      playAudio();
    } catch (e) {}
  }

  void playAudio() async {
    await audioPlayer.play();
    isPlaying.value = true;
    audioPlayer.positionStream.listen((event) {
      position.value = event;
    });

    audioPlayer.durationStream.listen((newDuration) {
      if (newDuration != null) duration.value = newDuration;
    });
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

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
