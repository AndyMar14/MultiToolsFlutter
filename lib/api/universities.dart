import 'dart:async';

class Universities {
  String name;
  List<String> domains;
  List<String> webPages;

  Universities(
      {required this.name, required this.domains, required this.webPages});

  static Universities fromJson(Map<String, dynamic> json) {
    return Universities(
        name: json['name'] as String,
        domains:
            ((json['domains'] ?? []) as List).map((e) => e as String).toList(),
        webPages: ((json['web_pages'] ?? []) as List)
            .map((e) => e as String)
            .toList());
  }
}
