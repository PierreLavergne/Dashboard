import 'package:dashboard_front_end/pages/authentication/authentication.dart';
import 'package:dashboard_front_end/pages/home/home.dart';
import 'package:dashboard_front_end/pages/root/root.dart';
import 'package:dashboard_front_end/utils/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      initialRoute: RootPage.route,
      onGenerateRoute: MyRoutes.generateRoute,
      routes: {
        RootPage.route: (context) => const RootPage(),
        HomePage.route: (context) => const HomePage(),
        AuthenticationPage.route: (context) => const AuthenticationPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
