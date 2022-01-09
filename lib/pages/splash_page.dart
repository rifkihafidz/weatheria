import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/providers/forecast_hourly_provider.dart';
import 'package:weatheria/providers/forecast_provider.dart';
import 'package:weatheria/providers/weather_provider.dart';
import 'package:weatheria/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Location location = Location();
  late bool serviceEnabled;

  Future<void> checkGpsPermission() async {
    await location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        print('Permission granted');
        checkGpsStatus();
      } else {
        print('Permission not granted');
        SystemNavigator.pop();
      }
    });
  }

  Future<void> checkGpsStatus() async {
    serviceEnabled = await location.serviceEnabled();

    if (serviceEnabled) {
      await getInit();
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      serviceEnabled = await location.requestService();
      if (serviceEnabled) {
        await getInit();
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        SystemNavigator.pop();
      }
    }
  }

  getInit() async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeather();
    await Provider.of<ForecastHourlyProvider>(context, listen: false)
        .getForecastsHourly();
    await Provider.of<ForecastProvider>(context, listen: false).getForecasts();
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      checkGpsPermission();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              child: Lottie.asset(
                'assets/splash.json',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              'Weatheria',
              style: whiteTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
