import 'package:flutter/material.dart';
import 'package:flutter_weather_demo/home_page/_manager/weather_manager.dart';
import 'package:flutter_weather_demo/home_page/_services/weather_service.dart';
import 'package:get_it/get_it.dart';

import 'home_page/homepage.dart';

void main() {
  registerViewModel();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

void registerViewModel() {
  GetIt.I.registerSingleton<WeatherService>(WeatherService());
  GetIt.I.registerSingleton<WeatherManager>(WeatherManager());
}
