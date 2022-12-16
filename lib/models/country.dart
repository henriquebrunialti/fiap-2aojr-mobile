class Country {
  String name;

Country({required this.name});

factory Country.fromJson(Map<String, dynamic> parsedJson) {
    return Country(
        name: parsedJson['name'] as String,
    );
  }
}