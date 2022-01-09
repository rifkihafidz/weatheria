import 'dart:convert';

import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weatheria/models/hourly_forecast_model.dart';
import 'package:weatheria/models/location_model.dart';
import 'package:weatheria/models/weather_model.dart';

class ForecastHourlyService {
  Location location = Location();
  var locationModel = LocationModel();

  Future<List<HourlyForecastModel>> getForecastHourly() async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = locationData.latitude!;
        locationModel.longitude = locationData.longitude!;
      });

      print('Get Hourly Forecast Start.');
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=${locationModel.latitude}&lon=${locationModel.longitude}&exclude=current,minutely,daily,alerts&units=metric&appid=6a7457c5db75047b06c52279f9cd80bb"));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['hourly'];

        List<HourlyForecastModel> forecasts = [];

        for (var item in data) {
          if (forecasts.length == 24) {
            break;
          }
          forecasts.add(HourlyForecastModel.fromJson(item));
        }

        print('Get Hourly Forecast Success.');
        return forecasts;
      } else {
        throw Exception('Failed to get hourly forecasts');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<HourlyForecastModel>> getForecastHourlyUsingCityName(
      WeatherModel weather) async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = double.parse(weather.latitude.toString());
        locationModel.longitude = double.parse(weather.longitude.toString());
      });

      print('Get Forecast Hourly Start.');
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=${locationModel.latitude}&lon=${locationModel.longitude}&exclude=daily,current,minutely,alerts&units=metric&appid=6a7457c5db75047b06c52279f9cd80bb"));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['hourly'];

        List<HourlyForecastModel> forecasts = [];

        for (var item in data) {
          forecasts.add(HourlyForecastModel.fromJson(item));
        }
        print('Get Forecast Success.');
        return forecasts;
      } else {
        throw Exception('Failed to get forecasts');
      }
    } catch (e) {
      throw e;
    }
  }
}
