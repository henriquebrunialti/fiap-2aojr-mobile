import 'package:custo_de_vida/models/category.dart';
import 'package:custo_de_vida/models/drink.dart';
import 'package:custo_de_vida/models/drink_card.dart';
import 'package:floor/floor.dart';

@dao
abstract class DrinkDao {
  @Query('SELECT * from DrinkCard')
  Future<List<DrinkCard>> findAll();

  @Query('SELECT * from DrinkCard where favorite = true')
  Future<List<DrinkCard>> findFavorites();

  @Query('SELECT * from DrinkCard where category = :category ')
  Future<List<DrinkCard>> findAllByCategory(String category);

  @insert
  Future<void> insertDrink(DrinkCard drink);

  @update
  Future<void> updateDrink(DrinkCard drink);
}
