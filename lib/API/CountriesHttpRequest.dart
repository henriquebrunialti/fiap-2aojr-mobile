import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country.dart';

class CountriesHttpRequest {
  static Future<List<Country>> getCountries() async {
      var headers = {
      'X-RapidAPI-Host': 'cost-of-living-prices-by-city-country.p.rapidapi.com',
      'X-RapidAPI-Key': '4c545c644bmsh13b3c6a7260055dp120109jsnf32158c091ec',
    };
    var url = Uri.parse(
        'https://cost-of-living-prices-by-city-country.p.rapidapi.com/get-countries-list');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200)
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    
    var body = res.body;

    return _getCountries(res.body);
  }

  static List<Country> _getCountries(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    final mapped = parsed.map<Country>((json) => Country.fromJson(json)).toList();

    return mapped;
  }
}
