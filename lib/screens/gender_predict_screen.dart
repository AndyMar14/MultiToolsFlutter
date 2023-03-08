import 'package:flutter/material.dart';
import 'package:tarea6/api/genderService.dart';

import '../api/gender.dart';

// ignore_for_file: prefer_const_constructors
class GenderPredict extends StatefulWidget {
  const GenderPredict({super.key});

  @override
  State<GenderPredict> createState() => _GenderPredictState();
}

class _GenderPredictState extends State<GenderPredict> {
  final TextEditingController txtName = TextEditingController();
  String name = '';
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gender Predict'),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: txtName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Inserte su nombre',
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('Predict'),
                onPressed: () {
                  setState(() {
                    name = txtName.text;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Text(
                  'Gender:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              FutureBuilder(
                future: GenderService().getGender(name),
                builder:
                    (BuildContext context, AsyncSnapshot<Gender> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.gender == 'male') {
                      return GenderCard(
                          name: snapshot.data!.gender, color: Colors.blue);
                    } else if (snapshot.data!.gender == 'female') {
                      return GenderCard(
                          name: snapshot.data!.gender, color: Colors.pink);
                    }
                  }
                  return Container();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String name;
  final Color color;

  const GenderCard({super.key, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Card(
        elevation: 0,
        color: color,
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(
              child: Text(
            name,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
