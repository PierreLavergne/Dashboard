import 'package:dashboard_front_end/utils/api.dart';
import 'package:dashboard_front_end/utils/location.dart';
import 'package:dashboard_front_end/utils/models/weather_response.dart';
import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Future<WeatherResponse> _future;
  late final Future<String> _location;

  @override
  void initState() {
    super.initState();
    _location = Location.getCurrentLocation();
    _future = _location.then((value) => Api.newWeatherWidget(location: value));
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
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Today",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child:
                      Image(image: NetworkImage("http:${snapshot.data!.icon}")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      Text(
                        "${snapshot.data!.temperature}°C",
                        style: const TextStyle(fontSize: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(snapshot.data!.location,
                            style: const TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
