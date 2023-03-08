import 'dart:convert';
import 'dart:ffi';
import 'package:location/location.dart';
import 'package:tarea6/api/weatherEntity.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String API_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String API_Key = 'ac00c0512cbc5c723a778a490d7a8db5';
  Location location = new Location();

  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  Future<WeatherEntity> getWeather() async {
    // ignore: prefer_interpolation_to_compose_strings
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return WeatherEntity(
            description: 'No location',
            main: '',
            temperature: (0.00) as double,
            name: '');
        ;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return WeatherEntity(
            description: 'No location',
            main: '',
            temperature: (0.00) as double,
            name: '');
        ;
      }
    }

    _locationData = await location.getLocation();
    var url = API_URL +
        "?lat=" +
        _locationData!.latitude.toString() +
        "&lon=" +
        _locationData!.longitude.toString() +
        "&appid=" +
        API_Key +
        '&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final weather = WeatherEntity.fromJson(responseJson);
      return weather;
    }

    return WeatherEntity(
        description: '', main: '', temperature: (0.00) as double, name: '');
  }
}
