import 'package:dashboard_front_end/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(AuthenticationPage.route);
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: const CircleBorder(),
          backgroundColor: Colors.black),
      child: const Icon(
        Icons.logout,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
