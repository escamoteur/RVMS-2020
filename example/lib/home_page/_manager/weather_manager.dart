import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_weather_demo/home_page/_model/weather_entry.dart';
import 'package:flutter_weather_demo/home_page/_services/weather_service.dart';
import 'package:functional_listener/functional_listener.dart';
import 'package:get_it/get_it.dart';

class WeatherManager {
  Command<String, List<WeatherEntry>> updateWeatherCmd;
  Command<bool, bool> setExecutionStateCmd;
  Command<String, String> textChangedCmd;

  WeatherManager() {
    // Command expects a bool value when executed and sets it as its own value
    setExecutionStateCmd = Command.createSync<bool, bool>((b) => b, true);

    // We pass the result of switchChangedCommand as canExecut to the upDateWeatherCommand
    updateWeatherCmd = Command.createAsync<String, List<WeatherEntry>>(
      GetIt.I<WeatherService>().update, // Wrapped function
      [], // Initial value
      restriction: setExecutionStateCmd,
    );

    // Will be called on every change of the searchfield
    textChangedCmd = Command.createSync((s) => s, '');

    textChangedCmd.debounce(Duration(milliseconds: 500)).listen(
          (filterText, _) => updateWeatherCmd.execute(filterText),
        );

    updateWeatherCmd.thrownExceptions.listen((ex, _) => print(ex.toString()));

    // Update data on startup
    updateWeatherCmd.execute();
  }
}
