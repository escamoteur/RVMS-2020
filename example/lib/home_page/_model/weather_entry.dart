import 'package:flutter_weather_demo/home_page/_model/weather_in_cities.dart';

class WeatherEntry {
  String cityName;
  String iconURL;
  double wind;
  double rain;
  double temperature;
  String description;

  WeatherEntry(City city) {
    this.cityName = city.name;
    this.iconURL = city.weather != null
        ? "https://openweathermap.org/img/w/${city.weather[0].icon}.png"
        : null;
    this.description =
        city.weather != null ? city.weather[0].description : null;
    this.wind = city.wind.speed.toDouble();
    this.rain = rain;
    this.temperature = city.main.temp;
  }
}
