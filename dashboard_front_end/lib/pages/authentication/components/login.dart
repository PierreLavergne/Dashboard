import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Required field !";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            validator: validate,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: TextFormField(
              obscureText: true,
              validator: validate,
              decoration: const InputDecoration(labelText: "Password"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: () {
                if (!_key.currentState!.validate()) {
                  return;
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2A28F0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const SizedBox(
                width: 200,
                height: 75,
                child: Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
