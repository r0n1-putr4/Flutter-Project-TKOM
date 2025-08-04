import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/base_url.dart';


class AirPage extends StatefulWidget {
  const AirPage({super.key});

  @override
  State<AirPage> createState() => _AirPageState();
}

class _AirPageState extends State<AirPage> {
  late Timer _timer;
  String _data = 'Loading...';
  int sensorAir = 1;//kondisi tidak terdeteksi air
  String gambar = "";

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/nodeMcu/getSensor.php'),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          _data = json.toString();
          sensorAir = json['sensorAir'];
          if(sensorAir==1){
            gambar = "assets/img/img_tidak_terdeteksi_air.png";
          }else{
            gambar = "assets/img/img_terdeteksi_air.png";
          }
        });
      } else {
        setState(() {
          _data = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _data = 'Exception: $e';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData(); // fetch initially
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _fetchData(); // fetch every 5 seconds
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel(); // Always cancel timers!
    super.dispose();
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
          child: Image.asset(gambar),
        ),
      ),
    );
  }
}
