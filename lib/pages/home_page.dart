import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tkom/pages/air_page.dart';
import 'package:flutter_project_tkom/pages/api_page.dart';
import 'package:flutter_project_tkom/pages/dht_page.dart';
import 'package:flutter_project_tkom/pages/lampu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Roni Putra"),
              accountEmail: Text("rn.putra@gmail.com"),
              currentAccountPicture: CircleAvatar(
                radius: 55,
                child: Icon(Icons.person, color: Colors.green, size: 65),
              ),
            ),

            ListTile(
              title: Text("Sensor DHT"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DhtPage()),
                );
              },
            ),
            ListTile(
              title: Text("Sensor API"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApiPage()),
                );
              },
            ),
            ListTile(
              title: Text("Sensor AIR"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AirPage()),
                );
              },
            ),

            ListTile(
              title: Text("Kontrol Lampu"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LampuPage()),
                );
              },
            ),

          ],
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
        child: Center(
          child: Expanded(child: Image.asset("assets/img/img_back_dua.png")),
        ),
      ),
    );
  }
}
