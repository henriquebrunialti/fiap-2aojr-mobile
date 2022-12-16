class Drink {
 late String name;
 late String thumb;
 late String id;

  Drink.fromJson(Map<String, dynamic> json) {
    name = json['strDrink'];
    thumb = json['strDrinkThumb'];
    id = json['idDrink'];
  }
}