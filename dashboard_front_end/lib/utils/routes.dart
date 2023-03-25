import 'package:dashboard_front_end/pages/authentication/authentication.dart';
import 'package:dashboard_front_end/pages/home/home.dart';
import 'package:dashboard_front_end/pages/root/root.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static const String rootRoute = '/root';
  static const String authRoute = '/auth';
  static const String homeRoute = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final params = Uri.parse(settings.name!).queryParameters;
    final route = Uri.parse(settings.name!).path;
    // print(params);
    switch (route) {
      case rootRoute:
        return MaterialPageRoute(builder: (_) => const RootPage());
      case authRoute:
        return MaterialPageRoute(builder: (_) => const AuthenticationPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
