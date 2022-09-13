import 'package:flutter/cupertino.dart';
import 'package:weatheria/models/forecast_model.dart';
import 'package:weatheria/models/weather_model.dart';
import 'package:weatheria/services/forecast_service.dart';

class ForecastProvider with ChangeNotifier {
  late ForecastModel _forecastDaily;

  ForecastModel get forecastDaily => _forecastDaily;

  set forecastDaily(ForecastModel forecastDaily) {
    _forecastDaily = forecastDaily;
    notifyListeners();
  }

  Future<void> getForecasts() async {
    try {
      ForecastModel forecastDaily = await ForecastService().getForecast();

      _forecastDaily = forecastDaily;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getForecastsUsingCityName(WeatherModel weatherModel) async {
    try {
      ForecastModel forecastDaily =
          await ForecastService().getForecastUsingCityName(weatherModel);

      _forecastDaily = forecastDaily;
    } catch (e) {
      print(e);
    }
  }
}
