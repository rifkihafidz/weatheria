import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatheria/cubit/forecast_cubit.dart';
import 'package:weatheria/cubit/weather_cubit.dart';
import 'package:weatheria/models/forecast_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ForecastCubit>().fetchForecast();
    context.read<WeatherCubit>().fetchLocationWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
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
                          Text('Latitude :'),
                          Text('${state.weather.latitude}'),
                          Text('Longitude :'),
                          Text('${state.weather.longitude}'),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: TextButton(
                              child: Text(
                                'Get Current Location + Weather',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                context
                                    .read<WeatherCubit>()
                                    .fetchLocationWeather();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Text(state.toString());
                  },
                ),
                SizedBox(height: 10),
                BlocConsumer<ForecastCubit, ForecastState>(
                  listener: (context, state) {
                    if (state is ForecastFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ForecastSuccess) {
                      return Column(
                        children: state.forecast.map((ForecastModel forecast) {
                          return Column(
                            children: [
                              Text(
                                  'Temperature: ${forecast.temperature.toString()}°'),
                              SizedBox(height: 5),
                              Text('Weather: ${forecast.weatherCondition}'),
                              SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      );
                    }
                    return Text(state.toString());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 // SingleChildScrollView(
                //   child: BlocConsumer<ForecastCubit, ForecastState>(
                //     listener: (context, state) {
                //       if (state is ForecastFailed) {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             backgroundColor: Colors.red,
                //             content: Text(state.error),
                //           ),
                //         );
                //       }
                //     },
                //     builder: (context, state) {
                //       if (state is ForecastSuccess) {
                //         return Center(
                //           child: ListView.separated(
                //               itemCount: state.forecast.length,
                //               itemBuilder: (context, index) {
                //                 String convertedDateTime =
                //                     DateTime.fromMillisecondsSinceEpoch(
                //                   state.forecast[index].dateTimeUnix! * 1000,
                //                 ).toString();
                //                 return ListTile(
                //                   title: Text(
                //                     'Date: $convertedDateTime, Temp: ${state.forecast[index].temperature} degree, Main: ${state.forecast[index].weatherMain}, Desc: ${state.forecast[index].weatherCondition}',
                //                   ),
                //                   subtitle: Image.network(
                //                       'http://openweathermap.org/img/wn/${state.forecast[index].icon}@2x.png'),
                //                 );
                //               },
                //               separatorBuilder: (context, index) {
                //                 return Divider();
                //               }),
                //         );
                //       }
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     },
                //   ),
                // ),