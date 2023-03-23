class WeatherResponse {
  final String location;
  final int temperature;
  final String icon;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: json["location"],
      temperature: json["temperature"],
      icon: json["icon"],
    );
  }

  @override
  String toString() {
    return "$location, $temperature, $icon";
  }

  const WeatherResponse({
    required this.location,
    required this.temperature,
    required this.icon,
  });
}
