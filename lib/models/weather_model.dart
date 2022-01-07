class WeatherModel {
  int? dateTimeUnix;
  num? temperature;
  String? weatherStatus;
  String? weatherIcon;
  num? humidity;
  num? latitude;
  num? longitude;

  WeatherModel({
    this.dateTimeUnix,
    this.temperature,
    this.weatherStatus,
    this.weatherIcon,
    this.humidity,
    this.latitude,
    this.longitude,
  });

  WeatherModel.fromMap(Map map) {
    this.dateTimeUnix = map['dt'];
    this.temperature = map['main']['temp'];
    this.weatherStatus = map['weather'][0]['main'];
    this.weatherIcon = map['weather'][0]['icon'];
    this.humidity = map['main']['humidity'];
    this.latitude = map['coord']['lat'];
    this.longitude = map['coord']['lon'];
  }

  // factory WeatherModel.fromJson(Map<dynamic, dynamic> json) {
  //   return WeatherModel(
  //     dateTimeUnix: json['dt'],
  //     temperature: json['main']['temp'],
  //     weatherStatus: json['weather'][0]['main'],
  //     weatherIcon: json['weather'][0]['icon'],
  //     humidity: json['main']['humidity'],
  //   );
  // }
}
