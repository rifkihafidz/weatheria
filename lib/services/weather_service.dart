import 'dart:convert';

import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weatheria/models/location_model.dart';
import 'package:weatheria/models/weather_model.dart';
import 'package:weatheria/utils/constanta.dart';

class WeatherService {
  Location location = Location();
  var locationModel = LocationModel();
  WeatherModel? weatherModel;

  Future<WeatherModel> getLocationWeather() async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = locationData.latitude!;
        locationModel.longitude = locationData.longitude!;
      });

      print('Get Weather Start.');
      final _response = await ApiConnection(
        'GET',
        'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=${locationModel.latitude}&lon=${locationModel.longitude}&appid=6a7457c5db75047b06c52279f9cd80bb',
        '',
      );
      weatherModel = weatherModelFromJson(_response.body);
      print('Get Weather Success.');
      return weatherModel!;
    } catch (e) {
      print('Error Weather: $e');
      throw e;
    }
  }

  Future<WeatherModel> getLocationWeatherUsingCityName(String cityName) async {
    try {
      print('Get Weather Start.');
      final _response = await ApiConnection(
          Type,
          'https://api.openweathermap.org/data/2.5/weather?units=metric&q=$cityName&appid=6a7457c5db75047b06c52279f9cd80bb',
          '');

      weatherModel = weatherModelFromJson(_response.body);
      print('Get Weather Success.');
      return weatherModel!;
    } catch (e) {
      throw e;
    }
  }
}
