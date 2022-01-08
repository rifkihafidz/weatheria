import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/models/forecast_model.dart';
import 'package:weatheria/providers/forecast_provider.dart';
import 'package:weatheria/providers/weather_provider.dart';
import 'package:weatheria/theme.dart';
import 'package:weatheria/widgets/forecast_card.dart';

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

    DateTime convertedDateTime = DateTime.fromMillisecondsSinceEpoch(
      weatherProvider.weather.dateTimeUnix! * 1000,
    );

    lottieWeather() {
      if (weatherProvider.weather.weatherStatus == 'Clouds') {
        return 'assets/clouds.json';
      } else if (weatherProvider.weather.weatherStatus == 'Thunderstorm') {
        return 'assets/thunderstorm.json';
      } else if (weatherProvider.weather.weatherStatus == 'Drizzle' ||
          weatherProvider.weather.weatherStatus == 'Rain') {
        return 'assets/rainy.json';
      } else if (weatherProvider.weather.weatherStatus == 'Snow') {
        return 'assets/snow.json';
      } else if (weatherProvider.weather.weatherIcon == '50d') {
        return 'assets/mist.json';
      } else if (weatherProvider.weather.weatherStatus == 'Clear') {
        return 'assets/clear.json';
      }
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 10, right: 15, left: 15),
        padding: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 17,
                ),
                SizedBox(width: 4),
                Text(
                  'Your current location',
                  style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              '${weatherProvider.weather.locationName}',
              style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    Widget topContent() {
      return Container(
        margin: EdgeInsets.only(top: 10, right: 15, left: 15),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              child: Lottie.asset(
                lottieWeather()!,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${weatherProvider.weather.weatherDescription}'.capitalize(),
              style: whiteTextStyle,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${weatherProvider.weather.temperature!.round()}',
                  style: whiteTextStyle.copyWith(fontSize: 30),
                ),
                Text(
                  '°C',
                  style: whiteTextStyle.copyWith(fontSize: 25),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.air,
                      color: whiteColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${weatherProvider.weather.windSpeed} m/s',
                      style: whiteTextStyle,
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Icon(
                      Icons.water,
                      color: whiteColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${weatherProvider.weather.humidity} %',
                      style: whiteTextStyle,
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: whiteColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      DateFormat('h:mm a').format(convertedDateTime).toString(),
                      style: whiteTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buttonUpdateWeather() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(10),
            backgroundColor: greyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Update Weather',
            style: whiteTextStyle.copyWith(fontWeight: FontWeight.w500),
          ),
          onPressed: () async {
            await weatherProvider.getWeather();
            await forecastProvider.getForecasts();
            setState(() {});
          },
        ),
      );
    }

    Widget bottomContent() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              '7-days forecast :',
              style: whiteTextStyle,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      forecastProvider.forecasts.map((ForecastModel forecast) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: ForecastCard(forecast),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                header(),
                topContent(),
                buttonUpdateWeather(),
                bottomContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
