class SpotifyMostListenArtistResponse {
  final String artist;
  final String icon;

  factory SpotifyMostListenArtistResponse.fromJson(Map<String, dynamic> json) {
    return SpotifyMostListenArtistResponse(
      artist: json["artist"],
      icon: json["icon"],
    );
  }

  @override
  String toString() {
    return "$artist, $icon";
  }

  const SpotifyMostListenArtistResponse({
    required this.artist,
    required this.icon,
  });
}
