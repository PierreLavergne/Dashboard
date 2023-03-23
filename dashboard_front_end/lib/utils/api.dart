import 'dart:async';
import 'dart:convert';

import 'package:dashboard_front_end/utils/models/weather_response.dart';
import 'package:http/http.dart' as http;

class Routes {
  static const String _endpoint = "http://localhost:3000";

  static final Uri register = Uri.parse("$_endpoint/auth/register");
  static final Uri login = Uri.parse("$_endpoint/auth/login");
  static final Uri newWidget = Uri.parse("$_endpoint/widgets");
}

class Api {
  static String _userId = "";

  static final Map<String, String> _headers = {
    "Content-Type": "application/json",
  };

  static Map<String, String> get _protectedHeaders => {
        "Content-Type": "application/json",
        "User": _userId,
      };

  static Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http.post(Routes.register,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword,
          },
        ),
        headers: _headers);
    if (response.statusCode != 201) {
      return Future.error(response.body);
    }
    final data = jsonDecode(response.body);
    _userId = data.id;
  }

  static Future<void> login(
      {required String email, required String password}) async {
    final response = await http.post(Routes.login,
        body: json.encode(
          {"email": email, "password": password},
        ),
        headers: _headers);
    if (response.statusCode != 201) {
      return Future.error(response.body);
    }
    final data = jsonDecode(response.body);
    _userId = data.id;
  }

  static Future<Map<String, dynamic>> _newWidget(
      {required String description, required Map<String, dynamic> data}) async {
    final response = await http.post(
      Routes.newWidget,
      body: json.encode({
        "description": description,
        "data": data,
      }),
      headers: _protectedHeaders,
    );
    if (response.statusCode != 201) {
      return Future.error(response.body);
    }
    return jsonDecode(response.body);
  }

  static Future<WeatherResponse> newWeatherWidget(
      {required String location}) async {
    final response = await _newWidget(
      description: "WEATHER_TEMP",
      data: {
        "location": location,
      },
    );

    return WeatherResponse.fromJson(response);
  }
}
