import 'package:custo_de_vida/components/CountryAutocomplete.dart';
import 'package:flutter/material.dart';

import '../components/CitiesAutocomplete.dart';
import '../models/country.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  _SearchState() {
    _countryAutocomplete = CountryAutocomplete(
      key: GlobalKey(),
      onCountrySelected: onCountrySelected,
      options: suggestions,
    );
  }
  TextEditingController countryController = TextEditingController();
  // GlobalKey<AutoCompleteTextFieldState<Country>> countryKey = GlobalKey();
  List<String> suggestions = [
    "USA",
    "UK",
    "Uganda",
    "Uruguay",
    "United Arab Emirates"
  ];

  List<String> cities = [];

  final CitiesAutocomplete _citiesAutocomplete = CitiesAutocomplete(key: GlobalKey());
  late CountryAutocomplete _countryAutocomplete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text('Menu'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Custo de vida"),
      ),
      body: Center(
          child: ListView(
        children: [
          _countryAutocomplete,
          _citiesAutocomplete
        ],
      )),
    );
  }

  void onCountrySelected(String countryName) {
    _countryAutocomplete.autocompleteSelection = countryName;
    if (countryName == "USA") {
      _citiesAutocomplete.setCities(
          ["Portland", "New York City", "Los Angeles", "San Francisco"]);
    } else if (countryName.toLowerCase() == "brasil") {
      _citiesAutocomplete.setCities([
        "São Paulo",
        "Rio de janeiro",
        "Porto Alegre",
        "Curitiba",
        "Salvador"
      ]);
    } else {
      _citiesAutocomplete.setCities([]);
    }

    

    setState(() {});
  }
}
