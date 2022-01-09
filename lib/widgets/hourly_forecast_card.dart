import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatheria/models/hourly_forecast_model.dart';
import 'package:weatheria/theme.dart';

class HourlyForecastCard extends StatelessWidget {
  final HourlyForecastModel forecast;

  const HourlyForecastCard(this.forecast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime convertedDateTime = DateTime.fromMillisecondsSinceEpoch(
      forecast.dateTimeUnix! * 1000,
    );
    lottieWeather() {
      if (forecast.weatherStatus == 'Clouds') {
        return 'assets/clouds.json';
      } else if (forecast.weatherStatus == 'Thunderstorm') {
        return 'assets/thunderstorm.json';
      } else if (forecast.weatherStatus == 'Drizzle' ||
          forecast.weatherStatus == 'Rain') {
        return 'assets/rainy.json';
      } else if (forecast.weatherStatus == 'Snow') {
        return 'assets/snow.json';
      } else if (forecast.icon == '50d') {
        return 'assets/mist.json';
      } else if (forecast.weatherStatus == 'Clear') {
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
          Text('${forecast.temperature!.round()}°C', style: whiteTextStyle),
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
                '${forecast.windSpeed} m/s',
                style: whiteTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
