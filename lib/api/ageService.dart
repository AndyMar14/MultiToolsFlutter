import 'dart:convert';

import 'package:tarea6/api/age.dart';
import 'package:http/http.dart' as http;

class AgeService {
  final String API_URL = 'https://api.agify.io/';

  // String name;

  // AgeService({required this.name}) : super();

  Future<Age> getAge(name) async {
    // ignore: prefer_interpolation_to_compose_strings
    var url = API_URL + "?name=" + name;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final age = Age.fromJson(responseJson);
      return age;
    }

    return Age(age: 0);
  }
}
