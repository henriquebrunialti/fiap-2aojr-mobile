import 'package:custo_de_vida/daos/category_dao.dart';
import 'package:custo_de_vida/daos/drink_dao.dart';
import 'package:custo_de_vida/models/category.dart';
import 'package:custo_de_vida/models/drink.dart';
import 'package:custo_de_vida/models/drink_card.dart';

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Category, DrinkCard])
abstract class AppDatabase extends FloorDatabase {
  CategoryDao get categoryDao;
  DrinkDao get drinkDao;

  Future<void> clearAllTables() async {
    await database.execute('DELETE FROM Category');
    await database.execute('DELETE FROM DrinkCard');
  }
}
