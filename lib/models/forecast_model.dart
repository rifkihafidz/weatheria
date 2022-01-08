class ForecastModel {
  int? dateTimeUnix;
  num? temperature;
  num? minTemperature;
  num? maxTemperature;
  String? weatherStatus;
  String? weatherDescription;
  String? icon;
  num? windSpeed;
  num? humidity;
  // num? latitude;
  // num? longitude;

  ForecastModel({
    this.dateTimeUnix,
    this.temperature,
    this.weatherStatus,
    this.weatherDescription,
    this.icon,
    this.minTemperature,
    this.maxTemperature,
    this.windSpeed,
    this.humidity,
    // this.latitude,
    // this.longitude,
  });

  ForecastModel.fromJson(Map<String, dynamic> json) {
    dateTimeUnix = json['dt'];
    temperature = json['temp']['day'];
    minTemperature = json['temp']['min'];
    maxTemperature = json['temp']['max'];
    weatherStatus = json['weather'][0]['main'];
    weatherDescription = json['weather'][0]['description'];
    icon = json['weather'][0]['icon'];
    windSpeed = json['wind_speed'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTimeUnix': dateTimeUnix,
      'temperature': temperature,
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
      'weatherStatus': weatherStatus,
      'weatherDescription': weatherDescription,
      'icon': icon,
      'windSpeed': windSpeed,
      'humidity': humidity,
    };
  }
}
