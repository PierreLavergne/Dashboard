import 'package:dashboard_front_end/pages/home/components/logout_button.dart';
import 'package:dashboard_front_end/pages/home/components/widget.dart';
import 'package:dashboard_front_end/pages/home/components/widgets/spotify_last_song.dart';
import 'package:dashboard_front_end/pages/home/components/widgets/spotify_most_listen_artist.dart';
import 'package:dashboard_front_end/pages/home/components/widgets/weather.dart';
import 'package:dashboard_front_end/utils/api.dart';
import 'package:dashboard_front_end/utils/models/widget_response.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MyWidget> _widgets = [];
  late Future<List<WidgetResponse>> _future;

  @override
  void initState() {
    super.initState();
    // _future = Api.getWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: const Color(0xffF5F4FA),
          body: Row(
            children: [
              AspectRatio(
                aspectRatio: 0.25,
                child: ColoredBox(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: Image(
                          width: 60,
                          image: AssetImage("EpiBoard-Logo.png"),
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: const BorderSide(
                                width: 1.5, color: Colors.white),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            _widgets.add(const MyWidget(
                              child: WeatherWidget(),
                            ));
                            setState(() {});
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("Weather Widget"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: const BorderSide(
                                width: 1.5, color: Colors.white),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            _widgets.add(const MyWidget(
                              child: SpotifyLastSongWidget(),
                            ));
                            setState(() {});
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("Spotify Last Song Widget"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: const BorderSide(
                                width: 1.5, color: Colors.white),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            _widgets.add(const MyWidget(
                              child: SpotifyMostListenArtistWidget(),
                            ));
                            setState(() {});
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("Spotify Most Listen Artist Widget"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [Logout()],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ColoredBox(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              "${_widgets.length} widgets are running",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: _widgets,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
