import 'package:flutter/cupertino.dart';
import 'package:weatheria/models/hourly_forecast_model.dart';
import 'package:weatheria/models/weather_model.dart';
import 'package:weatheria/services/forecast_hourly_service.dart';

class ForecastHourlyProvider with ChangeNotifier {
  late HourlyForecastModel _forecast;

  HourlyForecastModel get forecast => _forecast;

  set forecast(HourlyForecastModel forecast) {
    _forecast = forecast;
    notifyListeners();
  }

  Future<void> getForecastsHourly() async {
    try {
      HourlyForecastModel forecast =
          await ForecastHourlyService().getForecastHourly();

      _forecast = forecast;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getForecastsHourlyUsingCityName(
      WeatherModel weatherModel) async {
    try {
      HourlyForecastModel forecast = await ForecastHourlyService()
          .getForecastHourlyUsingCityName(weatherModel);

      _forecast = forecast;
    } catch (e) {
      print(e);
    }
  }
}
