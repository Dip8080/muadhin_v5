import 'package:muaddin/features/player_two/repository/model/moshaf_model.dart';

class Reciter {
  final int id;
  final String name;
  final List<Moshaf> moshaf;

  Reciter({
    required this.id,
    required this.name,
    required this.moshaf,
  });

  factory Reciter.fromJson(Map<String, dynamic> json) {
    return Reciter(
      id: json['id'],
      name: json['name'],
      moshaf: (json['moshaf'] as List)
          .map((e) => Moshaf.fromJson(e))
          .toList(),
    );
  }
}
