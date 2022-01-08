import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/models/forecast_model.dart';
import 'package:weatheria/providers/forecast_provider.dart';
import 'package:weatheria/providers/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProvider = Provider.of<WeatherProvider>(context);
    ForecastProvider forecastProvider = Provider.of<ForecastProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Text('Weather :'),
                    Text('${weatherProvider.weather.weatherStatus}'),
                    Text('Temperature :'),
                    Text('${weatherProvider.weather.temperature}°'),
                    Text('Humidity :'),
                    Text('${weatherProvider.weather.humidity}%'),
                    Text('Latitude :'),
                    Text('${weatherProvider.weather.latitude}'),
                    Text('Longitude :'),
                    Text('${weatherProvider.weather.longitude}'),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: TextButton(
                        child: Text(
                          'Get Current Location + Weather',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: Column(
                    children: forecastProvider.forecasts
                        .map((ForecastModel forecast) =>
                            Text('${forecast.weatherCondition}'))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
