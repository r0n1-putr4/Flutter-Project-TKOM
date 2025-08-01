import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tkom/pages/register_page.dart';

import '../utils/costume_button.dart';
import '../utils/costume_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Color(0xFF220033)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  CostumeInput(
                    label: "Username",
                    textEditingController: username,
                    icon: Icons.person,
                    textHint: "r0n1",
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  CostumeInput(
                    label: "Password",
                    textEditingController: password,
                    obscureText: true,
                    icon: Icons.key,
                    textHint: "*****",
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child:
                        isLoading
                            ? CircularProgressIndicator()
                            : CostumeButton(
                              bgColor: Colors.red,
                              labelButton: "LOGIN",
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    //  _login();
                                  }
                                });
                              },
                              labelColor: Colors.white,
                            ),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterPage(),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
