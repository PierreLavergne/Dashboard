class SpotifyResponse {
  final String artist;
  final String single;
  final String album;
  final String icon;

  factory SpotifyResponse.fromJson(Map<String, dynamic> json) {
    return SpotifyResponse(
      artist: json["artist"],
      single: json["single"],
      album: json["album"],
      icon: json["icon"],
    );
  }

  @override
  String toString() {
    return "$artist, $single, $album, $icon";
  }

  const SpotifyResponse({
    required this.artist,
    required this.single,
    required this.album,
    required this.icon,
  });
}
