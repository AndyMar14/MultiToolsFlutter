import 'package:flutter/material.dart';
import 'package:tarea6/api/weatherService.dart';
import 'package:location/location.dart';

import '../api/weatherEntity.dart';

// ignore_for_file: prefer_const_constructors
class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  int temperature = 0;

  Location location = new Location();

  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  void fetchLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea 6'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/clear.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FutureBuilder(
                    future: WeatherService().getWeather(),
                    builder: (BuildContext context,
                        AsyncSnapshot<WeatherEntity> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                snapshot.data!.temperature.toString() + '°C',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                            ),
                            Center(
                              child: Text(
                                snapshot.data!.description,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                            ),
                            Center(
                              child: Text(
                                snapshot.data!.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0),
                              ),
                            ),
                          ],
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
