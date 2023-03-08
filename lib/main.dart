import 'package:flutter/material.dart';

import 'shared/drawer_screen.dart';

// ignore_for_file: prefer_const_constructors
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tarea 6'),
        ),
        drawer: MenuDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Image(
                  image: AssetImage('assets/images/caja.jpg'),
                  height: 140,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
