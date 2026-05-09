class Moshaf {
  final int id;
  final String name;
  final String server;
  final Set<int> surahList;

  Moshaf({
    required this.id,
    required this.name,
    required this.server,
    required this.surahList,
  });

  factory Moshaf.fromJson(Map<String, dynamic> json) {
    return Moshaf(
      id: json['id'],
      name: json['name'],
      server: json['server'],
      surahList: (json['surah_list'] as String)
          .split(',')
          .map<int>((e) => int.parse(e))
          .toSet(),
    );
  }
}
