// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CategoryDao? _categoryDaoInstance;

  DrinkDao? _drinkDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DrinkCard` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `drinkId` TEXT NOT NULL, `thumb` TEXT NOT NULL, `category` TEXT NOT NULL, `isFavorite` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  DrinkDao get drinkDao {
    return _drinkDaoInstance ??= _$DrinkDao(database, changeListener);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'Category',
            (Category item) =>
                <String, Object?>{'id': item.id, 'title': item.title});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  @override
  Future<List<Category>> findAll() async {
    return _queryAdapter.queryList('SELECT * from Category',
        mapper: (Map<String, Object?> row) =>
            Category(title: row['title'] as String, id: row['id'] as int?));
  }

  @override
  Future<void> insertCategory(Category category) async {
    await _categoryInsertionAdapter.insert(category, OnConflictStrategy.abort);
  }
}

class _$DrinkDao extends DrinkDao {
  _$DrinkDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _drinkCardInsertionAdapter = InsertionAdapter(
            database,
            'DrinkCard',
            (DrinkCard item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'drinkId': item.drinkId,
                  'thumb': item.thumb,
                  'category': item.category,
                  'isFavorite': item.isFavorite ? 1 : 0
                }),
        _drinkCardUpdateAdapter = UpdateAdapter(
            database,
            'DrinkCard',
            ['id'],
            (DrinkCard item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'drinkId': item.drinkId,
                  'thumb': item.thumb,
                  'category': item.category,
                  'isFavorite': item.isFavorite ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DrinkCard> _drinkCardInsertionAdapter;

  final UpdateAdapter<DrinkCard> _drinkCardUpdateAdapter;

  @override
  Future<List<DrinkCard>> findAll() async {
    return _queryAdapter.queryList('SELECT * from DrinkCard',
        mapper: (Map<String, Object?> row) => DrinkCard(
            category: row['category'] as String,
            name: row['name'] as String,
            drinkId: row['drinkId'] as String,
            thumb: row['thumb'] as String,
            id: row['id'] as int?,
            isFavorite: (row['isFavorite'] as int) != 0));
  }

  @override
  Future<List<DrinkCard>> findFavorites() async {
    return _queryAdapter.queryList(
        'SELECT * from DrinkCard where favorite = true',
        mapper: (Map<String, Object?> row) => DrinkCard(
            category: row['category'] as String,
            name: row['name'] as String,
            drinkId: row['drinkId'] as String,
            thumb: row['thumb'] as String,
            id: row['id'] as int?,
            isFavorite: (row['isFavorite'] as int) != 0));
  }

  @override
  Future<List<DrinkCard>> findAllByCategory(String category) async {
    return _queryAdapter.queryList(
        'SELECT * from DrinkCard where category = ?1',
        mapper: (Map<String, Object?> row) => DrinkCard(
            category: row['category'] as String,
            name: row['name'] as String,
            drinkId: row['drinkId'] as String,
            thumb: row['thumb'] as String,
            id: row['id'] as int?,
            isFavorite: (row['isFavorite'] as int) != 0),
        arguments: [category]);
  }

  @override
  Future<void> insertDrink(DrinkCard drink) async {
    await _drinkCardInsertionAdapter.insert(drink, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDrink(DrinkCard drink) async {
    await _drinkCardUpdateAdapter.update(drink, OnConflictStrategy.abort);
  }
}
