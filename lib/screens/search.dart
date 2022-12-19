import 'package:custo_de_vida/API/categories_http_request.dart';
import 'package:custo_de_vida/API/drinks_http_request.dart';
import 'package:custo_de_vida/components/autocomplete_input.dart';
import 'package:custo_de_vida/components/hamburger_menu.dart';
import 'package:custo_de_vida/components/loading.dart';
import 'package:custo_de_vida/constants/text.dart';
import 'package:custo_de_vida/database/database.dart';
import 'package:custo_de_vida/models/category.dart';
import 'package:custo_de_vida/models/drink_card.dart';
import 'package:custo_de_vida/screens/details.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  List<Category> categories = [];
  List<DrinkCard> drinkCards = [];
  bool loading = false;
  bool loadingDrinks = false;

  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  loadCategories() async {
    setState(() {
      widget.loading = true;
    });

    var db = await _getDatabaseInstance('categories.db');

    List<Category> loadedCategories = [];

    var categsFromDb = await db.categoryDao.findAll();

    if (categsFromDb.isNotEmpty) {
      loadedCategories = categsFromDb;
    } else {
      var categsFromHttp = await CategoriesHttpRequest.getCategories();
      for (var cat in categsFromHttp) {
        db.categoryDao.insertCategory(cat);
      }
      loadedCategories = categsFromHttp;
    }

    setState(() {
      widget.categories = loadedCategories;
      widget.loading = false;
    });
  }

  _loadDrinks(String categName) async {
    setState(() {
      widget.drinkCards = [];
      widget.loadingDrinks = true;
    });
    var db = await _getDatabaseInstance('drinks.db');

    List<DrinkCard> loadedDrinks = [];

    if (widget.drinkCards.isEmpty) {
      var drinksFromDb = await db.drinkDao.findAllByCategory(categName);

      if (drinksFromDb.isNotEmpty) {
        loadedDrinks = drinksFromDb;
      } else {
        var drinksFromHttp = await DrinksHttpRequest.getDrinks(categName);
        for (var drink in drinksFromHttp) {
          db.drinkDao.insertDrink(drink);
        }
        loadedDrinks = drinksFromHttp;
      }

      setState(() {
        widget.drinkCards = loadedDrinks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      loadCategories();
    }
    return Scaffold(
      drawer: HamburgerMenu(),
      appBar: AppBar(
        title: const Text("Cocktails"),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            const Text('Buscar', style: headingStyle),
            AutocompleteInput(
              labelText: 'Categoria',
              hintText: 'Selecione uma categoria de drink',
              options: widget.categories,
              onOptionSelected: (categSelected) => _loadDrinks(categSelected),
            ),
            const Text('Resultados:', style: headingStyle),
            _buildList()
          ])),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (_, index) => _buildItem(index),
      itemCount: widget.drinkCards.length,
    );
  }

  Widget _buildItem(int index) {
    DrinkCard drink = widget.drinkCards[index];
    return Card(
      child: ListTile(
        title: Text(drink.name),
        trailing: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(drinkId: drink.drinkId),
              ),
            );
          },
        ),
        subtitle: Text(drink.category),
      ),
    );
  }

  Future<AppDatabase> _getDatabaseInstance(String dbName) async =>
      await $FloorAppDatabase.databaseBuilder(dbName).build();
}
