import 'dart:convert';

import 'package:custo_de_vida/models/drink_card.dart';
import 'package:http/http.dart' as http;

class DrinksHttpRequest {
  static Future<List<DrinkCard>> getDrinks(String category) async {
    var headers = {
      'X-RapidAPI-Host': 'the-cocktail-db.p.rapidapi.com',
      'X-RapidAPI-Key': '49c3bc4f03msh4cec94f885051aap14db54jsn2fc1173dacef',
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
    return _parseDrinkCards(res.body, category);
  }

  static List<DrinkCard> _parseDrinkCards(
      String responseBody, String category) {
    Map<String, dynamic> categories = jsonDecode(responseBody);
    final mapped = categories["drinks"].map<DrinkCard>((json) {
      var drink = DrinkCard.fromJson(json);
      drink.category = category;
      return drink;
    }).toList();
    print('MAPPED  :::::::: ${json}');
    return mapped;
  }
}
