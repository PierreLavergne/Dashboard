class SpotifyLastSongResponse {
  final String artist;
  final String single;
  final String album;
  final String icon;

  factory SpotifyLastSongResponse.fromJson(Map<String, dynamic> json) {
    return SpotifyLastSongResponse(
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

  const SpotifyLastSongResponse({
    required this.artist,
    required this.single,
    required this.album,
    required this.icon,
  });
}
