import 'package:dashboard_front_end/pages/authentication/components/login.dart';
import 'package:dashboard_front_end/pages/authentication/components/register.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  static const String route = '/auth';

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _isLogin = true;
  final List<Widget> _forms = [const Login(), const Register()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AspectRatio(
            aspectRatio: 0.84,
            child: ColoredBox(
              color: Color(0xff2A28F0),
              child: Center(
                child: Text(
                  "Welcome to EpiBoard",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 75),
              child: Column(
                children: [
                  const Image(image: AssetImage("EpiBoard-Logo.png")),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 121),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isLogin = true;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            "Log In",
                                            style: TextStyle(
                                                fontWeight: _isLogin
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                fontSize: 24),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: _isLogin
                                                ? Colors.black
                                                : Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isLogin = false;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            "Create Account",
                                            style: TextStyle(
                                                fontWeight: !_isLogin
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                fontSize: 24),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: !_isLogin
                                                ? Colors.black
                                                : Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: _forms[_isLogin ? 0 : 1],
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
