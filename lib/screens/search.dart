import 'package:custo_de_vida/API/DrinksHttpRequest.dart';
import 'package:custo_de_vida/components/autocomplete_input.dart';
import 'package:custo_de_vida/components/hamburger_menu.dart';
import 'package:custo_de_vida/database/database.dart';
import 'package:custo_de_vida/models/drink.dart';
import 'package:flutter/material.dart';

import '../API/CategoriesHttpRequest.dart';

class Search extends StatefulWidget {
  List<String> categories = [];
  String? selectedCategory;
  List<Drink> drinks = [
    Drink(
        alcoholic: 'Non alchoolic',
        category: "chocolate",
        instructions: 'lorem',
        name: 'Chocolate Drink',
        thumb:
            'https://www.thecocktaildb.com/images/media/drink/u6jrdf1487603173.jpg')
  ];

  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  initState() {
    super.initState();
    loadCategories();
  }

  loadCategories() async {
    var db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    // db.clearAllTables();
    List<String> loadedCategories = [];

    if (widget.categories.isEmpty) {
      var categsFromDb = await db.categoryDao.findAll();

      if (categsFromDb.isEmpty) {
        print('Loaded from HTTP Request');
        var categsFromHttp = await CategoriesHttpRequest.getCategories();

        for (var cat in categsFromHttp) {
          db.categoryDao.insertCategory(cat);
        }

        loadedCategories = categsFromHttp.map((c) => c.title).toList();
      } else {
        print('Loaded from FloorDB');
        loadedCategories = categsFromDb.map((e) => e.title).toList();
      }

      setState(() {
        widget.categories = loadedCategories;
      });
    }
  }

  loadDrinks(String categ) async {
    if (widget.drinks.isEmpty) {
      var drinksResponse = await DrinksHttpRequest.getDrinks(categ);
      setState(() {
        widget.drinks = drinksResponse;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const HamburgerMenu(),
        appBar: AppBar(
          title: const Text("Cocktails"),
        ),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const Text(
                'Buscar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              AutocompleteInput(
                labelText: 'Categoria',
                hintText: 'Selecione uma categoria de drink',
                options: widget.categories,
                onOptionSelected: (v) => setState(() {
                  widget.selectedCategory = v;
                }),
              ),
              const Text(
                'Resultados:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.black, height: 2),
                itemBuilder: (_, index) => _buildItem(index),
                itemCount: widget.drinks.length,
              ),
            ],
          ),
        )));
  }

  // Widget _renderDrinksList() {
  //   return ListView.separated(
  //     itemCount: drinks.length,
  //     itemBuilder: buildItem,
  //     separatorBuilder: (context, int index) => const Divider(height: 2, color: Colors.black12),
  //   );
  // }

  Widget _buildItem(int index) {
    Drink drink = widget.drinks[index];
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        title: Text(drink.name),
        trailing: Icon(Icons.search),
        subtitle: Text(drink.alcoholic),
        onTap: () {
          // TODO: navegar para a página de detalhes
          print(drink.alcoholic);
        },
      ),
    );
  }
}
