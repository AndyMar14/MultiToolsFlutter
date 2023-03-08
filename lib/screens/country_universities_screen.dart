import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea6/api/universities.dart';
import 'package:tarea6/api/universitiesService.dart';

// ignore_for_file: prefer_const_constructors
class CountryUniversities extends StatefulWidget {
  const CountryUniversities({super.key});

  @override
  State<CountryUniversities> createState() => _CountryUniversitiesState();
}

class _CountryUniversitiesState extends State<CountryUniversities> {
  final TextEditingController txtCountry = TextEditingController();
  String country = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('County Universities'),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: txtCountry,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Insert the City',
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('Search'),
                onPressed: () {
                  setState(() {
                    country = txtCountry.text;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Text(
                  'Universities:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              FutureBuilder(
                future: UniversitiesService().getUniversities(country),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var universiti = snapshot.data![index];
                          return CardUniversiti(uni: universiti);
                        },
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CardUniversiti extends StatelessWidget {
  Universities uni;

  CardUniversiti({super.key, required this.uni});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${uni.name} \n${uni.domains[0]}"),
      subtitle: Text("(${uni.webPages[0]})"),
    );
  }
}
