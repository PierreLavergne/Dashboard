import 'package:dashboard_front_end/utils/api.dart';
import 'package:dashboard_front_end/utils/models/spotify_last_song_response.dart';
import 'package:flutter/material.dart';

class SpotifyLastSongWidget extends StatefulWidget {
  const SpotifyLastSongWidget({super.key});

  @override
  State<SpotifyLastSongWidget> createState() => _SpotifyLastSongWidgetState();
}

class _SpotifyLastSongWidgetState extends State<SpotifyLastSongWidget> {
  late Future<SpotifyLastSongResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = Api.newSpotifyLastSongWidget();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Text("Failed to load widget");
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  "Last track played on Spotify",
                  style: TextStyle(fontSize: 35),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Image(image: NetworkImage(snapshot.data!.icon)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    snapshot.data!.single,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Text(
                  snapshot.data!.artist,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
          );
        });
  }
}
