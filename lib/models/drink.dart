import 'package:floor/floor.dart';

@entity
class Drink {
  late String name;
  late String drinkId;
  late String thumb;
  late String category;
  late String alcoholic;
  late String instructions;

  Drink.fromJson(Map<String, dynamic> json) {
    drinkId = json['idDrink'];
    name = json['strDrink'];
    thumb = json['strDrinkThumb'];
    category = json['strCategory'];
    alcoholic = json['strAlcoholic'];
    instructions = json['strInstructions'];
  }
}
