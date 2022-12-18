import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category.dart';

class CategoriesHttpRequest {
  static Future<List<Category>> getCategories() async {
    var headers = {
      'X-RapidAPI-Host': 'the-cocktail-db.p.rapidapi.com',
      'X-RapidAPI-Key': 'trocar',
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

    return _extractCategories(res.body);
  }

  static List<Category> _extractCategories(String responseBody) {
    Map<String, dynamic> categories = jsonDecode(responseBody);
    print(categories);
    final mapped =
        categories["drinks"].map<Category>((json) => Category.fromJson(json)).toList();
    return mapped;
  }
}
