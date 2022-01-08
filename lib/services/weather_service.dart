import 'dart:convert';

import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weatheria/models/location_model.dart';
import 'package:weatheria/models/weather_model.dart';

class WeatherService {
  Location location = Location();
  var locationModel = LocationModel();
  var weatherModel = WeatherModel();

  Future<WeatherModel> getLocationWeather() async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = locationData.latitude!;
        locationModel.longitude = locationData.longitude!;
      });

      print('Get Weather Start.');
      final request = await get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=${locationModel.latitude}&lon=${locationModel.longitude}&appid=6a7457c5db75047b06c52279f9cd80bb',
        ),
      );
      Map response = jsonDecode(request.body);
      weatherModel = WeatherModel.fromMap(response);
      print('Get Weather Success.');
      return weatherModel;
    } catch (e) {
      throw e;
    }
  }
}
