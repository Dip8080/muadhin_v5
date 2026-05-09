class PrayerTimeModel {
  final String name;
  final String time;

  PrayerTimeModel({required this.name, required this.time});

  static List<PrayerTimeModel> fromJosn(Map<String, dynamic> timing) {
    return timing.entries.map((entry) {
      return PrayerTimeModel(name: entry.key, time: entry.value);
    }).toList();
  }
}
