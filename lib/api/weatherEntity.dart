import 'dart:ffi';

class WeatherEntity {
  String main;
  String description;
  double temperature;
  String name;
  String icon;
  int cod;

  WeatherEntity(
      {required this.description,
      required this.main,
      required this.temperature,
      required this.icon,
      required this.cod,
      required this.name});

  static WeatherEntity fromJson(Map<String, dynamic> json) {
    return WeatherEntity(
        description: json['weather'][0]['description'] as String,
        main: json['weather'][0]['main'] as String,
        temperature: json['main']['temp'] as double,
        icon: json['weather'][0]['icon'] as String,
        cod: json['cod'] as int,
        name: json['name'] as String);
  }
}
