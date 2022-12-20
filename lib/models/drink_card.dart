import 'package:custo_de_vida/models/drink.dart';
import 'package:floor/floor.dart';

@entity
class DrinkCard {
  @PrimaryKey(autoGenerate: true)
  int? id;

  late String name;
  late String drinkId;
  late String thumb;
  late String category;
  late bool isFavorite;

  DrinkCard(
      {required this.category,
      required this.name,
      required this.drinkId,
      required this.thumb,
      this.id,
      this.isFavorite = false});

  DrinkCard.fromJson(Map<String, dynamic> json) {
    drinkId = json['idDrink'];
    name = json['strDrink'];
    thumb = json['strDrinkThumb'];
    isFavorite = false;
  }

  DrinkCard.fromDrink(Drink drink) {
    drinkId = drink.drinkId;
    name = drink.name;
    thumb = drink.thumb;
    category = drink.category;
    isFavorite = false;
  }
}
