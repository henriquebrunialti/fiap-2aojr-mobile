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
  late String? ingredient6;
  late String? ingredient7;
  late String? ingredient8;
  late String? ingredient9;
  late String? ingredient10;
  late String? ingredient11;
  late String? ingredient12;
  late String? ingredient13;
  late String? ingredient14;
  late String? ingredient15;

  Drink.fromJson(Map<String, dynamic> json) {
    drinkId = json['idDrink'];
    name = json['strDrink'];
    thumb = json['strDrinkThumb'];
    category = json['strCategory'];
    alcoholic = json['strAlcoholic'];
    instructions = json['strInstructions'];

    ingredient1 = json['strIngredient1'];
    ingredient2 = json['strIngredient2'];
    ingredient3 = json['strIngredient3'];
    ingredient4 = json['strIngredient4'];
    ingredient5 = json['strIngredient5'];

    ingredient6 = json['strIngredient6'];
    ingredient7 = json['strIngredient7'];
    ingredient8 = json['strIngredient8'];
    ingredient9 = json['strIngredient9'];
    ingredient10 = json['strIngredient10'];

    ingredient11 = json['strIngredient11'];
    ingredient12 = json['strIngredient12'];
    ingredient13 = json['strIngredient13'];
    ingredient14 = json['strIngredient14'];
    ingredient15 = json['strIngredient15'];
  }
}
