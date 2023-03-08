import 'package:flutter/material.dart';
import 'package:tarea6/api/ageService.dart';

import '../api/age.dart';

// ignore_for_file: prefer_const_constructors
class AgePredict extends StatefulWidget {
  const AgePredict({super.key});

  @override
  State<AgePredict> createState() => _AgePredictState();
}

class _AgePredictState extends State<AgePredict> {
  final TextEditingController txtName = TextEditingController();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Predict'),
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
                padding: EdgeInsets.fromLTRB(0, 25, 0, 20),
                child: Text(
                  'Age Range:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              FutureBuilder(
                future: AgeService().getAge(name),
                builder: (BuildContext context, AsyncSnapshot<Age> snapshot) {
                  if (snapshot.hasData) {
                    String group = '';
                    String image = '';
                    if (snapshot.data!.age >= 14 && snapshot.data!.age <= 26) {
                      group = 'joven: ${snapshot.data!.age} años';
                      image = 'assets/images/joven.jpeg';
                    } else if (snapshot.data!.age >= 27 &&
                        snapshot.data!.age <= 59) {
                      group = 'Adulto: ${snapshot.data!.age} años';
                      image = 'assets/images/adulto.jpeg';
                    } else if (snapshot.data!.age >= 60) {
                      group = 'Persona Mayor: ${snapshot.data!.age} años';
                      image = 'assets/images/mayor.jpeg';
                    } else {
                      group = '';
                      image = 'assets/images/no-image.png';
                    }
                    return Column(
                      children: [
                        Text(
                          group,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Image(
                          image: AssetImage(image),
                          height: 140,
                        ),
                      ],
                    );
                    // return Padding(
                    //   padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    //   child: Text(group,
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold)),
                    // );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
