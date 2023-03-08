import 'dart:convert';

import 'package:tarea6/api/gender.dart';
import 'package:http/http.dart' as http;

class GenderService {
  final String API_URL = 'https://api.genderize.io/';

  Future<Gender> getGender(name) async {
    // ignore: prefer_interpolation_to_compose_strings
    var url = API_URL + "?name=" + name;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final gender = Gender.fromJson(responseJson);
      return gender;
    }

    return Gender(gender: ' ');
  }
}
