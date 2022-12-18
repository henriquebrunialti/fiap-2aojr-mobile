import 'package:custo_de_vida/API/CategoriesHttpRequest.dart';
import 'package:custo_de_vida/API/DrinksHttpRequest.dart';
import 'package:custo_de_vida/components/CategoryAutocomplete.dart';
import 'package:custo_de_vida/components/hamburger_menu.dart';
import 'package:flutter/material.dart';

import '../components/CocktailsAutocomplete.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  _SearchState() {
    _CategoryAutocomplete = CategoryAutocomplete(
      key: GlobalKey(),
      onCategorySelected: onCategorySelected,
      options: suggestions,
    );
  }

  TextEditingController CategoryController = TextEditingController();
  List<String> suggestions = [];
  List<String> cities = [];

  final CitiesAutocomplete _citiesAutocomplete =
      CitiesAutocomplete(key: GlobalKey());
  late CategoryAutocomplete _CategoryAutocomplete;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Scaffold>(
        future: loadSearch(),
        builder: (context, AsyncSnapshot<Scaffold> snapshot) {
          if (snapshot.hasData) {
            //TODO: Tela de loading mais bonita
            return snapshot.data ?? const Scaffold(body: Text("loading"));
          } else {
            return const Scaffold(body: Text("loading"));
          }
        });
  }

  Future<Scaffold> loadSearch() async {
    if (suggestions.isEmpty) {
      var c = await CategoriesHttpRequest.getCategory();
      suggestions = c.map((c) => c.strCategory).toList();
      _CategoryAutocomplete.options = suggestions;
    }

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
              _CategoryAutocomplete,
              _citiesAutocomplete,
              const Text(
                'Resultados:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )));
  }

  void onCategorySelected(String categoryName) async {
    _CategoryAutocomplete.autocompleteSelection = categoryName;
    _CategoryAutocomplete.onCategorySelected = onCategorySelected;
    var drinks = await DrinksHttpRequest.getDrinks(categoryName);
    _citiesAutocomplete.setCities(drinks.map((d) => d.name).toList());
    setState(() {});
  }
}
