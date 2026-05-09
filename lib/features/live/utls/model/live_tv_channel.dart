class LiveTvChannel {
  final int id;
  final String name;
  final String url;

  LiveTvChannel({
    required this.id,
    required this.name,
    required this.url,
  });

  factory LiveTvChannel.fromJson(Map<String, dynamic> json) {
    return LiveTvChannel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}