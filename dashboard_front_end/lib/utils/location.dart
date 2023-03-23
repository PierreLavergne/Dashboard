import 'package:geolocator/geolocator.dart';

class Location {
  static Future<String> getCurrentLocation() async {
    final coordinates = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return "${coordinates.latitude},${coordinates.longitude}";
  }
}
