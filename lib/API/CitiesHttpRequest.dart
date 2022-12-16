import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/city.dart';

class CitiesHttpRequest {
  static Future<List<City>> getCities(String countryName) async {
      var headers = {
      'X-RapidAPI-Host': 'cost-of-living-prices-by-city-country.p.rapidapi.com',
      'X-RapidAPI-Key': '4c545c644bmsh13b3c6a7260055dp120109jsnf32158c091ec',
    };
    var url = Uri.parse(
        'https://cost-of-living-prices-by-city-country.p.rapidapi.com/get-cities-by-country?country=$countryName');
    // var res = await http.get(url, headers: headers);
    // if (res.statusCode != 200)
      // throw Exception('http.get error: statusCode= ${res.statusCode}');
    
    return _getCities("");
  }

  static List<City> _getCities(String responseBody) {
    String s = '''{
                    \"0\": {
                      \"city_id\": 2091,
                      \"city_name\": \"Adana\",
                      \"country_name\": \"Turkey\",
                      \"exchange_rate\": {
                        \"AUD\": 1.4484359433959557,
                        \"CAD\": 1.2931853699196991,
                        \"CHF\": 0.9949030712680023,
                        \"CNY\": 6.732105004770595,
                        \"CZK\": 23.68500578500454,
                        \"DKK\": 7.120542460210748,
                        \"EUR\": 0.9569899984975258,
                        \"GBP\": 0.828260488849631,
                        \"HKD\": 7.8499784198755345,
                        \"JPY\": 134.58206906979618,
                        \"KRW\": 1287.4055092000233,
                        \"NOK\": 9.926106974256012,
                        \"NZD\": 1.6011906869561305,
                        \"RUB\": 57.496521819850464,
                        \"SEK\": 10.156284122674634,
                        \"UAH\": 29.538467648474608,
                        \"USD\": 1
                      },
                      \"exchange_rates_updated\": {
                        \"date\": \"2022-06-14\",
                        \"timestamp\": 1655211544
                      },
                      \"last_update\": 1664532933188
                    }
                  }''';
    final parsed = jsonDecode(s).cast<Map<String, dynamic>>();
    final mapped = parsed.map<City>((json) => City.fromJson(json)).toList();

    return mapped;
  }
}
