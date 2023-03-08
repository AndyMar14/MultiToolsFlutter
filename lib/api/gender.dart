class Gender {
  String gender;

  Gender({required this.gender});

  static Gender fromJson(Map<String, dynamic> json) {
    if (json['gender'] == null) {
      return Gender(gender: '');
    }
    return Gender(gender: json['gender'] as String);
  }
}
