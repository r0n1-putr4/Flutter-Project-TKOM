import 'package:flutter/material.dart';
import 'package:flutter_project_tkom/pages/login_page.dart';
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
        MaterialPageRoute(builder: (_) => const LoginPage()),
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
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Color(0xFF220033)],
          ),
        ),
        child: Center(
          child: Expanded(child: Image.asset("assets/img/img_bg_tiga.png")),
        ),
      ),
    );
  }
}
