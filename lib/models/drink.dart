import 'package:floor/floor.dart';

@entity
class Drink {
  late String name;
  late String drinkId;
  late String thumb;
  late String category;
  late String alcoholic;
  late String instructions;
  late String? ingredient1;
  late String? ingredient2;
  late String? ingredient3;
  late String? ingredient4;
  late String? ingredient5;

  Drink.fromJson(Map<String, dynamic> json) {
    drinkId = json['idDrink'];
    name = json['strDrink'];
    thumb = json['strDrinkThumb'];
    category = json['strCategory'];
    alcoholic = json['strAlcoholic'];
    instructions = json['strInstructions'];

    ingredient1 = json['strIngredients1'];
    ingredient2 = json['strIngredients2'];
    ingredient3 = json['strIngredients3'];
    ingredient4 = json['strIngredients4'];
    ingredient5 = json['strIngredients5'];
  }
}
