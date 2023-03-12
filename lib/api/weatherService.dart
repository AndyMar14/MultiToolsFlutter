import 'dart:convert';
import 'dart:ffi';
import 'package:location/location.dart';
import 'package:tarea6/api/weatherEntity.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String API_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String API_Key = 'ac00c0512cbc5c723a778a490d7a8db5';

  getWeather(lat, lon) async {
    // ignore: prefer_interpolation_to_compose_strings
    var url = API_URL +
        "?lat=" +
        lat +
        "&lon=" +
        lon +
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
        description: '',
        main: '',
        temperature: (0.00) as double,
        name: '',
        cod: 400,
        icon: '');
  }

  getWeatherByName(name) async {
    // ignore: prefer_interpolation_to_compose_strings
    var url = API_URL + "?q=" + name + "&appid=" + API_Key + '&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final weather = WeatherEntity.fromJson(responseJson);
      return weather;
    }

    return WeatherEntity(
        description: '',
        main: '',
        temperature: (0.00) as double,
        name: '',
        cod: 400,
        icon: '');
  }
}
