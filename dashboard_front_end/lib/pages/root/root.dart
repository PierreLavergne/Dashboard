import 'package:dashboard_front_end/pages/authentication/authentication.dart';
import 'package:dashboard_front_end/pages/home/home.dart';
import 'package:dashboard_front_end/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:html' as html;

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  static const String route = '/root';

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    var uri = Uri.dataFromString(html.window.location.href);
    if (Api.isLogged) {
      super.initState();
      return;
    }

    Map<String, String> params = uri.queryParameters;

    if (params.containsKey("user-id")) {
      Api.userId = params["user-id"].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Api.isLogged) {
      return const HomePage();
    } else {
      return const AuthenticationPage();
    }
  }
}
