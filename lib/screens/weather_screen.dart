import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tarea6/api/weatherService.dart';
import 'package:location/location.dart';

import '../api/weatherEntity.dart';

// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  double temperature = 0;
  String city = '';
  String weatherName = '';
  String weatherImage = 'clearsky';
  String main = '';
  String icon = '01d';
  String errorMessage = '';

  final TextEditingController txtCity = TextEditingController();

  void fetchLocation() async {
    Location location = Location();
    bool _serviceEnabled = false;
    PermissionStatus? _permissionGranted;
    LocationData? _locationData;
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
        ;
      }
    }

    _locationData = await location.getLocation();
    WeatherEntity weather = await WeatherService().getWeather(
        _locationData.latitude.toString(), _locationData.longitude.toString());

    setState(() {
      temperature = weather.temperature;
      city = weather.name;
      weatherName = weather.description;
      main = weather.main;
      icon = weather.icon;
      weatherImage = weatherName.replaceAll(' ', '').toLowerCase();
      errorMessage = "";
    });
  }

  void searchLocation(name) async {
    try {
      Location location = Location();
      LocationData? _locationData;
      WeatherEntity weather = await WeatherService().getWeatherByName(name);

      if (weather.cod == 200) {
        setState(() {
          temperature = weather.temperature;
          city = weather.name;
          weatherName = weather.description;
          main = weather.main;
          icon = weather.icon;
          weatherImage = weatherName.replaceAll(' ', '').toLowerCase();
          errorMessage = "";
        });
      } else {
        setState(() {
          errorMessage =
              "Sorry, we don't have data about this city. Try another one.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage =
            "Sorry, we don't have data about this city. Try another one.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Weather'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$weatherImage.png'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
            ),
          ),
          child: temperature == null
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Center(
                            child: Image.network(
                              'https://openweathermap.org/img/wn/' +
                                  icon +
                                  '@2x.png',
                              width: 100,
                            ),
                          ),
                          Center(
                            child: Text(
                              '$temperature °C',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 60.0),
                            ),
                          ),
                          Center(
                            child: Text(
                              weatherName,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 40.0),
                            ),
                          ),
                          Center(
                            child: Text(
                              city,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 40.0),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: 300,
                            child: TextField(
                              controller: txtCity,
                              onSubmitted: (String input) {
                                searchLocation(input);
                                txtCity.clear();
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                              decoration: InputDecoration(
                                hintText: 'Search another location...',
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 32.0, left: 32.0),
                            child: Text(errorMessage,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize:
                                        Platform.isAndroid ? 15.0 : 20.0)),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }
}
