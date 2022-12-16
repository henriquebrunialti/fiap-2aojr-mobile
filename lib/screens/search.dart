import 'package:custo_de_vida/API/CitiesHttpRequest.dart';
import 'package:custo_de_vida/API/CountriesHttpRequest.dart';
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
  List<String> suggestions = ["brazil"];

  List<String> cities = [];

  final CitiesAutocomplete _citiesAutocomplete = CitiesAutocomplete(key: GlobalKey());
  late CountryAutocomplete _countryAutocomplete;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Scaffold>(
      future: loadSearch(),
      builder:(context, AsyncSnapshot<Scaffold> snapshot) {
        if(snapshot.hasData)
        {
          return snapshot.data ?? const Scaffold(body: Text("loading"));
        }
        else
        {
          return const Scaffold(body: Text("loading"));
        }
      }
    );
  }

  Future<Scaffold> loadSearch() async {
    if (suggestions.isEmpty) {
      var c = await CountriesHttpRequest.getCountries();
      suggestions = c.map((c) => c.name).toList();
      _countryAutocomplete.options = suggestions;
    }
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
          children: [_countryAutocomplete, _citiesAutocomplete],
        )));
  }

  void onCountrySelected(String countryName) async {
    print('selected $countryName');
    _countryAutocomplete.autocompleteSelection = countryName;
    _countryAutocomplete.onCountrySelected = onCountrySelected;
    var citiesResult = await CitiesHttpRequest.getCities(countryName);
    print('cities result\n$citiesResult');
    if(citiesResult.isEmpty) {
      return;
    }
    _citiesAutocomplete.setCities(citiesResult.map((e) => e.name).toList());
    setState(() {});
  }
}
