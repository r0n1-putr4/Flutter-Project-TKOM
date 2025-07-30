import 'package:flutter/material.dart';
import 'package:flutter_project_tkom/pages/register_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void loadLogin() async {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RegisterPage()),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Color(0xFF220033)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [Image.asset("assets/img/img_splash.png")]),
          ),
        ),
      ),
    );
  }
}
