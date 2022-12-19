import 'dart:convert';

import 'package:custo_de_vida/models/drink.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/drink.dart';

class CategoriesHttpRequest {
  static Future<List<Category>> getCategories() async {
    var headers = {
      'X-RapidAPI-Host': 'the-cocktail-db.p.rapidapi.com',
      'X-RapidAPI-Key': '49c3bc4f03msh4cec94f885051aap14db54jsn2fc1173dacef',
    };

    var params = {
      'c': 'list',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url =
        Uri.parse('https://the-cocktail-db.p.rapidapi.com/list.php?$query');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200)
      throw Exception('http.get error: statusCode= ${res.statusCode}');

    return _parseCategories(res.body);
  }

  static List<Category> _parseCategories(String responseBody) {
    Map<String, dynamic> categories = jsonDecode(responseBody);
    final mapped = categories["drinks"]
        .map<Category>((json) => Category.fromJson(json))
        .toList();
    return mapped;
  }
}
