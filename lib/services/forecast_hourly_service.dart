import 'dart:convert';
import 'dart:developer';

import 'package:location/location.dart';
import 'package:weatheria/models/hourly_forecast_model.dart';
import 'package:weatheria/models/location_model.dart';
import 'package:weatheria/models/weather_model.dart';
import 'package:weatheria/utils/constanta.dart';

class ForecastHourlyService {
  Location location = Location();
  var locationModel = LocationModel();
  HourlyForecastModel? hourlyForecastModel;

  Future<HourlyForecastModel> getForecastHourly() async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = locationData.latitude!;
        locationModel.longitude = locationData.longitude!;
      });

      print('Get Hourly Forecast Start.');

      final _response = await ApiConnection(
        'GET',
        "https://api.openweathermap.org/data/2.5/onecall?lat=${locationModel.latitude}&lon=${locationModel.longitude}&exclude=current,minutely,daily,alerts&units=metric&appid=6a7457c5db75047b06c52279f9cd80bb",
        '',
      );

      hourlyForecastModel = hourlyForecastModelFromJson(_response.body);
      print('Get Hourly Forecast Success.');
      return hourlyForecastModel!;
    } catch (e) {
      throw e;
    }
  }

  Future<HourlyForecastModel> getForecastHourlyUsingCityName(
      WeatherModel weather) async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = double.parse(weather.coord!.lat.toString());
        locationModel.longitude = double.parse(weather.coord!.lon.toString());
      });

      print('Get Forecast Hourly Start.');

      final _response = await ApiConnection(
          'GET',
          "https://api.openweathermap.org/data/2.5/onecall?lat=${locationModel.latitude}&lon=${locationModel.longitude}&exclude=daily,current,minutely,alerts&units=metric&appid=6a7457c5db75047b06c52279f9cd80bb",
          '');

      hourlyForecastModel = hourlyForecastModelFromJson(_response.body);

      print('Get Forecast Success.');
      return hourlyForecastModel!;
    } catch (e) {
      throw e;
    }
  }
}
