import 'dart:convert';

import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weatheria/models/forecast_model.dart';
import 'package:weatheria/models/location_model.dart';
import 'package:weatheria/models/weather_model.dart';
import 'package:weatheria/utils/constanta.dart';

class ForecastService {
  Location location = Location();
  var locationModel = LocationModel();
  ForecastModel? forecastModel;

  Future<ForecastModel> getForecast() async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = locationData.latitude!;
        locationModel.longitude = locationData.longitude!;
      });

      print('Get Forecast Start.');

      final _response = await ApiConnection(
        'GET',
        "https://api.openweathermap.org/data/2.5/onecall?lat=${locationModel.latitude}&lon=${locationModel.longitude}&exclude=current,minutely,hourly,alerts&units=metric&appid=6a7457c5db75047b06c52279f9cd80bb",
        '',
      );

      forecastModel = forecastModelFromJson(_response.body);

      print('Get Forecast Success.');
      return forecastModel!;
    } catch (e) {
      throw e;
    }
  }

  Future<ForecastModel> getForecastUsingCityName(WeatherModel weather) async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = double.parse(weather.coord!.lat.toString());
        locationModel.longitude = double.parse(weather.coord!.lon.toString());
      });

      print('Get Forecast Start.');

      final _response = await ApiConnection(
        "GET",
        "https://api.openweathermap.org/data/2.5/onecall?lat=${locationModel.latitude}&lon=${locationModel.longitude}&exclude=current,minutely,hourly,alerts&units=metric&appid=6a7457c5db75047b06c52279f9cd80bb",
        '',
      );

      forecastModel = forecastModelFromJson(_response.body);

      print('Get Forecast Success.');
      return forecastModel!;
    } catch (e) {
      throw e;
    }
  }
}
