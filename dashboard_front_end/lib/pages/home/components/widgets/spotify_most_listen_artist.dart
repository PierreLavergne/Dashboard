import 'package:dashboard_front_end/utils/api.dart';
import 'package:dashboard_front_end/utils/models/spotify_most_listen_artist_response.dart';
import 'package:flutter/material.dart';

class SpotifyMostListenArtistWidget extends StatefulWidget {
  const SpotifyMostListenArtistWidget({super.key});

  @override
  State<SpotifyMostListenArtistWidget> createState() =>
      _SpotifyMostListenArtistWidgetState();
}

class _SpotifyMostListenArtistWidgetState
    extends State<SpotifyMostListenArtistWidget> {
  late Future<SpotifyMostListenArtistResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = Api.newSpotifyMostListenWidget();
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
                  "Most listen artist on Spotify",
                  style: TextStyle(fontSize: 35),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Image(image: NetworkImage(snapshot.data!.icon)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    snapshot.data!.artist,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
