import 'package:flutter/material.dart';

class HomePageDua extends StatefulWidget {
  const HomePageDua({super.key});

  @override
  State<HomePageDua> createState() => _HomePageDuaState();
}

class _HomePageDuaState extends State<HomePageDua> {
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
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 180,
                    height: 220,
                    margin: EdgeInsets.all(10),
                    child: Card(
                      elevation: 4,
                      child: Center(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset('assets/img/promo.png'),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            Center(
                              child: Text("40"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 180,
                    height: 220,
                    margin: EdgeInsets.all(10),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text("Card dengan ukuran & margin"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
