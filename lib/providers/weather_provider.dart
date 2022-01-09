import 'package:flutter/cupertino.dart';
import 'package:weatheria/models/weather_model.dart';
import 'package:weatheria/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  late WeatherModel _weather;

  WeatherModel get weather => _weather;

  set weather(WeatherModel weather) {
    _weather = weather;
    notifyListeners();
  }

  Future<void> getWeather() async {
    try {
      WeatherModel weather = await WeatherService().getLocationWeather();

      _weather = weather;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getWeatherUsingCityName(String cityName) async {
    try {
      WeatherModel weather =
          await WeatherService().getLocationWeatherUsingCityName(cityName);

      _weather = weather;
    } catch (e) {
      print(e);
    }
  }
}
