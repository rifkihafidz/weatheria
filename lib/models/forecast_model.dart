class ForecastModel {
  int? dateTimeUnix;
  num? temperature;
  String? weatherMain;
  String? weatherCondition;
  String? icon;
  // num? latitude;
  // num? longitude;

  ForecastModel({
    this.dateTimeUnix,
    this.temperature,
    this.weatherMain,
    this.weatherCondition,
    this.icon,
    // this.latitude,
    // this.longitude,
  });

  factory ForecastModel.fromJson(Map<dynamic, dynamic> json) {
    return ForecastModel(
      dateTimeUnix: json['dt'],
      temperature: json['temp']['day'],
      weatherMain: json['weather'][0]['main'],
      weatherCondition: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      // latitude: json['lat'],
      // longitude: json['lon'],
    );
  }
}
