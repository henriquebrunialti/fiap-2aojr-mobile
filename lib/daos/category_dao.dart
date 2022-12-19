import 'package:custo_de_vida/models/category.dart';
import 'package:floor/floor.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * from Category')
  Future<List<Category>> findAll();

  @insert
  Future<void> insertCategory(Category category);
}
