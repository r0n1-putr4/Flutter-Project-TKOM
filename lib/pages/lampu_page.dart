import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/base_url.dart';

class LampuPage extends StatefulWidget {
  const LampuPage({super.key});

  @override
  State<LampuPage> createState() => _LampuPageState();
}

class _LampuPageState extends State<LampuPage> {
  String _data = 'Loading...';
  bool isLoading = false;
  int _status = 0;

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/nodeMcu/getSensor.php'),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          _status = json['aktifLampu'];
          _data = json.toString();
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

  Future<void> _setAktifLampu(String aktif) async {
    try {
      isLoading = true;

      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/nodeMcu/setLampu.php"),
        body: {"aktifLampu": aktif.toString()}, // perbaikan di sini
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _status = json['aktifLampu'];
        _data = json.toString();
      } else {
        setState(() {
          _data = 'Error: ${response.statusCode}';
        });
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        _data = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kontrol Lampu", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, //
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _status == 1 ? 'Lampu Hidup' : 'Lampu Mati',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),

            SizedBox(height: 20), // Spasi antara teks dan tombol
            RawMaterialButton(
              onPressed: () {
                setState(() {
                  _setAktifLampu(_status == 1 ? "0" : "1");
                });
              },
              shape: const CircleBorder(),
              fillColor: _status == 1 ? Colors.white : Colors.red,
              elevation: 4,
              constraints: const BoxConstraints.tightFor(
                width: 250,
                height: 250,
              ),
              child: Icon(
                Icons.lightbulb,
                color: _status == 1 ? Colors.red : Colors.white,
                size: 90,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
