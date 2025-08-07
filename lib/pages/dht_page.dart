import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../utils/base_url.dart';

class DhtPage extends StatefulWidget {
  const DhtPage({super.key});

  @override
  State<DhtPage> createState() => _DhtPageState();
}

class _DhtPageState extends State<DhtPage> {
  late Timer _timer;
  String _data = 'Loading...';
  double temperature = 0.0;
  int humidity = 0;
  int koneksi = 0;
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
          temperature = json['suhu'];
          humidity = json['kelembapan'];
          gambar = json['gambar'];
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
        iconTheme: const IconThemeData(
          color: Colors.white, //
        ),
      ),
      body: Container(
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
                    style: TextStyle(color: Colors.white,fontSize: 25),
                  )
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'LAB-P2 JURUSAN TI',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SfRadialGauge(
                          backgroundColor: Colors.transparent, // penting!
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              startAngle: 135,
                              endAngle: 45,
                              interval: 10,
                              radiusFactor: 0.9,
                              showTicks: true,
                              showLabels: true,
                              axisLineStyle: const AxisLineStyle(
                                thickness: 0.1,
                                thicknessUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.bothFlat,
                                color: Color(0xFF8800CC),
                              ),
                              majorTickStyle: const MajorTickStyle(
                                color: Colors.white,
                                length: 0.07,
                                thickness: 1.5,
                              ),
                              axisLabelStyle: const GaugeTextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              pointers: <GaugePointer>[
                                MarkerPointer(
                                  value: temperature,
                                  markerType: MarkerType.circle,
                                  color: Colors.white,
                                  markerWidth: 12,
                                  markerHeight: 12,
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  angle: 90,
                                  positionFactor: 0.1,
                                  widget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '$temperature °C',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color:
                                              Colors
                                                  .amberAccent, // sesuai gambar
                                        ),
                                      ),
                                      const Text(
                                        'SUHU',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SfRadialGauge(
                          backgroundColor: Colors.transparent, // penting!
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              startAngle: 135,
                              endAngle: 45,
                              interval: 10,
                              radiusFactor: 0.9,
                              showTicks: true,
                              showLabels: true,
                              axisLineStyle: const AxisLineStyle(
                                thickness: 0.1,
                                thicknessUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.bothFlat,
                                color: Color(0xFF8800CC),
                              ),
                              majorTickStyle: const MajorTickStyle(
                                color: Colors.white,
                                length: 0.07,
                                thickness: 1.5,
                              ),
                              axisLabelStyle: const GaugeTextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              pointers: <GaugePointer>[
                                MarkerPointer(
                                  value: humidity.toDouble(),
                                  markerType: MarkerType.circle,
                                  color: Colors.white,
                                  markerWidth: 12,
                                  markerHeight: 12,
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  angle: 90,
                                  positionFactor: 0.1,
                                  widget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '$humidity %',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color:
                                              Colors
                                                  .amberAccent, // sesuai gambar
                                        ),
                                      ),
                                      const Text(
                                        'Kelembapan',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
    ;
  }
}
