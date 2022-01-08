import 'package:flutter/cupertino.dart';
import 'package:weatheria/models/forecast_model.dart';
import 'package:weatheria/services/forecast_service.dart';

class ForecastProvider with ChangeNotifier {
  late List<ForecastModel> _forecasts = [];

  List<ForecastModel> get forecasts => _forecasts;

  set forecasts(List<ForecastModel> forecasts) {
    _forecasts = forecasts;
    notifyListeners();
  }

  Future<void> getForecasts() async {
    try {
      List<ForecastModel> forecasts = await ForecastService().getForecast();

      _forecasts = forecasts;
    } catch (e) {
      print(e);
    }
  }
}
