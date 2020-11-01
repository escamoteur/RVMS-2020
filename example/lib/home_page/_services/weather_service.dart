import 'dart:convert';
import 'dart:io';

import 'package:flutter_weather_demo/home_page/_model/weather_entry.dart';
import 'package:flutter_weather_demo/home_page/_model/weather_in_cities.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // Async function that queries the REST API and converts the result into the form our ListViewBuilder can consume
  Future<List<WeatherEntry>> update(String filtertext) async {
    const url =
        "https://api.openweathermap.org/data/2.5/box/city?bbox=12,32,15,37,10&appid=27ac337102cc4931c24ba0b50aca6bbd";

    final result = await http.get(url).timeout(const Duration(seconds: 5));
    if (result.statusCode == HttpStatus.ok) {
      // convert JSON result into a List of WeatherEntries
      return WeatherInCities.fromJson(
              json.decode(result.body) as Map<String, dynamic>)
          .cities // we are only interested in the Cities part of the response
          .where((weatherInCity) =>
              filtertext == null ||
              filtertext
                  .isEmpty || // if filtertext is null or empty we return all returned entries
              weatherInCity.name.toUpperCase().startsWith(
                  filtertext.toUpperCase())) // otherwise only matching entries
          .map((weatherInCity) => WeatherEntry(
              weatherInCity)) // Convert City object to WeatherEntry
          .toList(); // aggregate entries to a List
    }
    return [];
  }
}
