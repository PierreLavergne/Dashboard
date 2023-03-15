import 'dart:convert';

import 'package:http/http.dart' as http;

class Routes {
  static const String _endpoint = "http://localhost:3000";

  static final Uri register = Uri.parse("$_endpoint/auth/register");
  static final Uri login = Uri.parse("$_endpoint/auth/login");
}

class Api {
  static final Map<String, String> _headers = {
    "Content-Type": "application/json",
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
  }
}
