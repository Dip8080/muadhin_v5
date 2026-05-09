import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muaddin/features/live/utls/model/live_tv_channel.dart';

class LiveTvService {
  static Future<List<LiveTvChannel>> fetchChannels() async {
    final response = await http.get(
      Uri.parse(
          "https://mp3quran.net/api/v3/live-tv?language=eng"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['livetv'];

      return list
          .map((json) => LiveTvChannel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load channels");
    }
  }
}