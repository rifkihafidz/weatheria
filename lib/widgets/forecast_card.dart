import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatheria/models/forecast_model.dart';
import 'package:weatheria/theme.dart';

class ForecastCard extends StatelessWidget {
  final Daily daily;
  const ForecastCard(
    this.daily, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime convertedDateTime = DateTime.fromMillisecondsSinceEpoch(
      daily.dt! * 1000,
    );
    lottieWeather() {
      if (daily.weather![0].main == 'Clouds') {
        return 'assets/clouds.json';
      } else if (daily.weather![0].main == 'Thunderstorm') {
        return 'assets/thunderstorm.json';
      } else if (daily.weather![0].main == 'Drizzle' ||
          daily.weather![0].main == 'Rain') {
        return 'assets/rainy.json';
      } else if (daily.weather![0].main == 'Snow') {
        return 'assets/snow.json';
      } else if (daily.weather![0].icon == '50d') {
        return 'assets/mist.json';
      } else if (daily.weather![0].main == 'Clear') {
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
            DateFormat('EEE').format(convertedDateTime).toString(),
            style: whiteTextStyle,
          ),
          Text(
            DateFormat('dd/MM').format(convertedDateTime).toString(),
            style: whiteTextStyle,
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: 50,
            child: Lottie.asset(
              lottieWeather()!,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${daily.weather![0].main}',
            style: whiteTextStyle,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_upward,
                size: 14,
                color: whiteColor,
              ),
              SizedBox(width: 3),
              Text('${daily.temp!.max!.round()}°C', style: whiteTextStyle),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.water,
                size: 14,
                color: whiteColor,
              ),
              SizedBox(width: 5),
              Text('${daily.humidity} %', style: whiteTextStyle),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_downward,
                size: 14,
                color: whiteColor,
              ),
              SizedBox(width: 3),
              Text('${daily.temp!.min!.round()}°C', style: whiteTextStyle),
            ],
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
                '${daily.windSpeed} m/s',
                style: whiteTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
