import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors
class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 150,
            color: Colors.white,
            child: const Image(
              image: AssetImage('assets/images/andy.jpg'),
              height: 140,
            ),
          ),
          Container(
            height: 20,
            color: Colors.white,
            child: const Center(
              child: Text(
                'Andy Rafael',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          Container(
            height: 20,
            color: Colors.white,
            child: const Center(
              child: Text(
                'Marmolejos Rosario',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          Container(
            height: 20,
            color: Colors.white,
            child: const Center(
              child: Text(
                'andyrafaelmar@gmail.com',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          Container(
            height: 20,
            color: Colors.white,
            child: const Center(
              child: Text(
                '+1 809-702-1805',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
