import 'dart:developer';
import 'package:dashboard_front_end/pages/home.dart';
import 'package:dashboard_front_end/utils/api.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool _isError = false;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Required field !";
    }
    if (_isError) {
      return "Something went wrong !";
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
            controller: _emailController,
            validator: validate,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: validate,
              decoration: const InputDecoration(labelText: "Password"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: TextFormField(
              controller: _passwordConfirmController,
              obscureText: true,
              validator: validate,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: () {
                if (!_key.currentState!.validate()) {
                  return;
                }
                setState(() {
                  _isError = false;
                });
                Api.register(
                  email: _emailController.text,
                  password: _passwordController.text,
                  confirmPassword: _passwordConfirmController.text,
                )
                    .then(
                  (value) => Navigator.of(context).pushNamed(HomePage.route),
                )
                    .catchError((err) {
                  setState(() {
                    _isError = true;
                  });
                  _key.currentState!.validate();
                });
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
                    "Create account",
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
