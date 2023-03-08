class Age {
  int age;

  Age({required this.age});

  static Age fromJson(Map<String, dynamic> json) {
    if (json['age'] == null) {
      return Age(age: 0);
    }
    return Age(age: json['age'] as int);
  }
}
