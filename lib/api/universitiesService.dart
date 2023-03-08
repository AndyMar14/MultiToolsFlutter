import 'dart:convert';

import 'package:http/http.dart' as http;
import 'universities.dart';

class UniversitiesService {
  final String API_URL = 'http://universities.hipolabs.com/';

  static List<Universities> fromJsonList(List<dynamic> jsonList) {
    List<Universities> universitiesList = [];
    if (jsonList != null) {
      for (var pelicula in jsonList) {
        final universities = Universities.fromJson(pelicula);
        universitiesList.add(universities);
      }
    }
    return universitiesList;
  }

  Future<List<Universities>> getUniversities(name) async {
    // ignore: prefer_interpolation_to_compose_strings
    var url = API_URL + "search?country=" + name;

    if (name != '') {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        // print(responseJson);
        final universities = UniversitiesService.fromJsonList(responseJson);
        return universities;
      }
    }

    return <Universities>[];
  }
}
