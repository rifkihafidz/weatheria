import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:weatheria/cubit/weather_cubit.dart';
import 'package:weatheria/models/location_model.dart';
import 'package:weatheria/models/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<WeatherCubit>().fetchLocationWeather();
    super.initState();
  }

  Location location = Location();
  var locationModel = LocationModel();
  var weatherModel = WeatherModel();

  Future<WeatherModel> getLocationWeather() async {
    await location.getLocation().then((locationData) {
      locationModel.latitude = locationData.latitude!;
      locationModel.longitude = locationData.longitude!;
    });
    print('Get Location Success');
    print('Get Weather Start');
    final request = await get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=${locationModel.latitude}&lon=${locationModel.longitude}&appid=6a7457c5db75047b06c52279f9cd80bb',
      ),
    );
    Map response = jsonDecode(request.body);
    weatherModel = WeatherModel.fromMap(response);
    return weatherModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<WeatherCubit, WeatherState>(
                listener: (context, state) {
                  if (state is WeatherFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is WeatherSuccess) {
                    return Column(
                      children: [
                        Text('Weather :'),
                        Text('${state.weather.weatherStatus}'),
                        Text('Temperature :'),
                        Text('${state.weather.temperature}°'),
                        Text('Humidity :'),
                        Text('${state.weather.humidity}%'),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// FutureBuilder(
//   future: getLocationWeather(),
//   builder: (context, AsyncSnapshot snapshot) {
//     switch (snapshot.connectionState) {
//       case ConnectionState.waiting:
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       case ConnectionState.done:
//         weatherModel = snapshot.data;
//         return Column(
//           children: [
//             Text('Weather :'),
//             Text('${weatherModel.weatherStatus}'),
//             Text('Temperature :'),
//             Text('${weatherModel.temperature}°'),
//             Text('Humidity :'),
//             Text('${weatherModel.humidity}%'),
//           ],
//         );
//       default:
//         return SizedBox();
//     }
//   },
// ),
