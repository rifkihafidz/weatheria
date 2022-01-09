class HourlyForecastModel {
  int? dateTimeUnix;
  num? temperature;

  String? weatherStatus;
  String? icon;
  num? windSpeed;
  // num? latitude;
  // num? longitude;

  HourlyForecastModel({
    this.dateTimeUnix,
    this.temperature,
    this.weatherStatus,
    this.icon,
    this.windSpeed,
    // this.latitude,
    // this.longitude,
  });

  HourlyForecastModel.fromJson(Map<String, dynamic> json) {
    dateTimeUnix = json['dt'];
    temperature = json['temp'];
    weatherStatus = json['weather'][0]['main'];
    icon = json['weather'][0]['icon'];
    windSpeed = json['wind_speed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTimeUnix': dateTimeUnix,
      'temperature': temperature,
      'weatherStatus': weatherStatus,
      'icon': icon,
      'windSpeed': windSpeed,
    };
  }
}
