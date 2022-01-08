import 'dart:convert';

import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weatheria/models/forecast_model.dart';
import 'package:weatheria/models/location_model.dart';

class ForecastService {
  Location location = Location();
  var locationModel = LocationModel();
  var forecastModel = ForecastModel();

  Future<List<ForecastModel>> getForecast() async {
    try {
      await location.getLocation().then((locationData) {
        locationModel.latitude = locationData.latitude!;
        locationModel.longitude = locationData.longitude!;
      });
      print('Get Location Success');
      print('Get Forecast Start');
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=${locationModel.latitude}&lon=${locationModel.longitude}&exclude=current,minutely,hourly,alerts&units=metric&appid=6a7457c5db75047b06c52279f9cd80bb"));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['daily'];

        List<ForecastModel> forecasts = [];

        for (var item in data) {
          forecasts.add(ForecastModel.fromJson(item));
        }

        return forecasts;
      } else {
        throw Exception('Failed to get forecasts');
      }
    } catch (e) {
      throw e;
    }
  }
}
