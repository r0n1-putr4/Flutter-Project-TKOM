import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/base_url.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  late Timer _timer;
  String _data = 'Loading...';
  int sensorApi = 1; //kondisi tidak terdeteksi api
  String gambar = "";
  int koneksi = 0;

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/nodeMcu/getSensor.php'),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          _data = json.toString();
          sensorApi = json['sensorApi'];
          if (sensorApi == 1) {
            gambar = "assets/img/img_tidak_ada_api.png";
          } else {
            gambar = "assets/img/img_detect_api.png";
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

  Future<void> _cekKoneksi() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      koneksi = 0;
      print("Jaringan Terputus");
    } else {
      koneksi = 1;
      print("Terhubung Ke Jaringan");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cekKoneksi();
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
      appBar: AppBar(
        title: const Text("Monitoring", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
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
          child:
              koneksi == 0
                  ? Text(
                    "Koneksi Terputus",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )
                  : Expanded(child: Image.asset(gambar)),
        ),
      ),
    );
  }
}
