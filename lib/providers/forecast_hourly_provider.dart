import 'package:flutter/cupertino.dart';
import 'package:weatheria/models/hourly_forecast_model.dart';
import 'package:weatheria/models/weather_model.dart';
import 'package:weatheria/services/forecast_hourly_service.dart';

class ForecastHourlyProvider with ChangeNotifier {
  late List<HourlyForecastModel> _forecasts = [];

  List<HourlyForecastModel> get forecasts => _forecasts;

  set forecasts(List<HourlyForecastModel> forecasts) {
    _forecasts = forecasts;
    notifyListeners();
  }

  Future<void> getForecastsHourly() async {
    try {
      List<HourlyForecastModel> forecasts =
          await ForecastHourlyService().getForecastHourly();

      _forecasts = forecasts;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getForecastsHourlyUsingCityName(
      WeatherModel weatherModel) async {
    try {
      List<HourlyForecastModel> forecasts = await ForecastHourlyService()
          .getForecastHourlyUsingCityName(weatherModel);

      _forecasts = forecasts;
    } catch (e) {
      print(e);
    }
  }
}
