import 'package:floor/floor.dart';

@entity
class Drink {
  late String name;
  late String drinkId;
  late String thumb;
  late String category;
  late String alcoholic;
  late String instructions;
  late String strIngredient1;
  late String strIngredient2;
  late String strIngredient3;
  late String strIngredient4;
  late String strIngredient5;

  Drink.fromJson(Map<String, dynamic> json) {
    drinkId = json['idDrink'];
    name = json['strDrink'];
    thumb = json['strDrinkThumb'];
    category = json['strCategory'];
    alcoholic = json['strAlcoholic'];
    instructions = json['strInstructions'];
    strIngredient1 = json['strIngredients1'];
    strIngredient2 = json['strIngredients2'];
    strIngredient3 = json['strIngredients3'];
    strIngredient4 = json['strIngredients4'];
    strIngredient5 = json['strIngredients5'];
  }
}
