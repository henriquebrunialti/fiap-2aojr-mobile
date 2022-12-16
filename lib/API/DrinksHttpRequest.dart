import 'dart:convert';

import 'package:custo_de_vida/models/drinks.dart';
import 'package:http/http.dart' as http;

import '../models/drinkscategory.dart';

class DrinksHttpRequest {
  static Future<List<Drink>> getDrinks(String category) async {
    var headers = {
      'X-RapidAPI-Host': 'the-cocktail-db.p.rapidapi.com',
      'X-RapidAPI-Key': 'trocar',
    };

    var params = {
      'c': category,
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url =
        Uri.parse('https://the-cocktail-db.p.rapidapi.com/filter.php?$query');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200)
      throw Exception('http.get error: statusCode= ${res.statusCode}');

    return _getDrinks(res.body);
  }

  static List<Drink> _getDrinks(String responseBody) {
    Map<String, dynamic> categories = jsonDecode(responseBody);
    final mapped =
        categories["drinks"].map<Drink>((json) => Drink.fromJson(json)).toList();
    return mapped;
  }
}
