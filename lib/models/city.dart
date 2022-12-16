class City {
  String name;
  String countryName;

  //TODO adcionar a lista de preços aqui para carregar no Load Cities By Country e economizar uma chamada de API.
  //Lembrando que temos o limite de 100 apenas por mês.

City({required this.name, required this.countryName});

factory City.fromJson(Map<String, dynamic> parsedJson) {
    print('parsedJSON: $parsedJson');
    return City(
        name: parsedJson['city_name'] as String,
        countryName: parsedJson['country_name'] as String,
    );
  }
}