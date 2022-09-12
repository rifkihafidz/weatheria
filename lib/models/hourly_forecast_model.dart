import 'dart:convert';

HourlyForecastModel hourlyForecastModelFromJson(String str) =>
    HourlyForecastModel.fromJson(json.decode(str));

String hourlyForecastModelToJson(HourlyForecastModel data) =>
    json.encode(data.toJson());

class HourlyForecastModel {
  HourlyForecastModel({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.hourly,
  });

  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  List<Hourly>? hourly;

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) =>
      HourlyForecastModel(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        hourly:
            List<Hourly>.from(json["hourly"].map((x) => Hourly.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "hourly": List<dynamic>.from(hourly!.map((x) => x.toJson())),
      };
}

class Hourly {
  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
    this.rain,
  });

  int? dt;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List<Weather>? weather;
  double? pop;
  Rain? rain;

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json["dt"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        uvi: json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        pop: json["pop"].toDouble(),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
        "pop": pop,
        "rain": rain == null ? null : rain!.toJson(),
      };
}

class Rain {
  Rain({
    this.the1H,
  });

  double? the1H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the1H: json["1h"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "1h": the1H,
      };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  String? main;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

// enum Description {
//   CLEAR_SKY,
//   FEW_CLOUDS,
//   SCATTERED_CLOUDS,
//   MODERATE_RAIN,
//   BROKEN_CLOUDS,
//   LIGHT_RAIN,
//   OVERCAST_CLOUDS
// }

// final descriptionValues = EnumValues({
//   "broken clouds": Description.BROKEN_CLOUDS,
//   "clear sky": Description.CLEAR_SKY,
//   "few clouds": Description.FEW_CLOUDS,
//   "light rain": Description.LIGHT_RAIN,
//   "moderate rain": Description.MODERATE_RAIN,
//   "overcast clouds": Description.OVERCAST_CLOUDS,
//   "scattered clouds": Description.SCATTERED_CLOUDS
// });

// enum Main { CLEAR, CLOUDS, RAIN }

// final mainValues =
//     EnumValues({"Clear": Main.CLEAR, "Clouds": Main.CLOUDS, "Rain": Main.RAIN});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
