class WeatherModel {
  int? dateTimeUnix;
  num? temperature;
  String? weatherStatus;
  String? weatherDescription;
  String? weatherIcon;
  num? humidity;
  num? latitude;
  num? longitude;
  String? locationName;
  num? windSpeed;

  WeatherModel({
    this.dateTimeUnix,
    this.temperature,
    this.weatherStatus,
    this.weatherDescription,
    this.weatherIcon,
    this.humidity,
    this.latitude,
    this.longitude,
    this.locationName,
    this.windSpeed,
  });

  WeatherModel.fromMap(Map map) {
    this.dateTimeUnix = map['dt'];
    this.temperature = map['main']['temp'];
    this.weatherStatus = map['weather'][0]['main'];
    this.weatherDescription = map['weather'][0]['description'];
    this.weatherIcon = map['weather'][0]['icon'];
    this.humidity = map['main']['humidity'];
    this.latitude = map['coord']['lat'];
    this.longitude = map['coord']['lon'];
    this.locationName = map['name'];
    this.windSpeed = map['wind']['speed'];
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
