// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatheria/models/hourly_forecast_model.dart';
import 'package:weatheria/theme.dart';

class HourlyForecastCard extends StatelessWidget {
  final Hourly hourly;

  const HourlyForecastCard(this.hourly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime convertedDateTime = DateTime.fromMillisecondsSinceEpoch(
      hourly.dt! * 1000,
    );
    lottieWeather() {
      if (hourly.weather![0].main == 'Clouds') {
        return 'assets/clouds.json';
      } else if (hourly.weather![0].main == 'Thunderstorm') {
        return 'assets/thunderstorm.json';
      } else if (hourly.weather![0].main == 'Drizzle' ||
          hourly.weather![0].main == 'Rain') {
        return 'assets/rainy.json';
      } else if (hourly.weather![0].main == 'Snow') {
        return 'assets/snow.json';
      } else if (hourly.weather![0].icon == '50d') {
        return 'assets/mist.json';
      } else if (hourly.weather![0].main == 'Clear') {
        return 'assets/clear.json';
      }
    }

    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            DateFormat('HH:mm').format(convertedDateTime).toString(),
            style: whiteTextStyle,
          ),
          Text('${hourly.temp!.round()}°C', style: whiteTextStyle),
          SizedBox(height: 5),
          Container(
            height: 50,
            width: 50,
            child: Lottie.asset(
              lottieWeather()!,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.air,
                size: 14,
                color: whiteColor,
              ),
              SizedBox(width: 5),
              Text(
                '${hourly.windSpeed} m/s',
                style: whiteTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
