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

  ForecastModel.fromJson(Map<String, dynamic> json) {
    dateTimeUnix = json['dt'];
    temperature = json['temp']['day'];
    weatherMain = json['weather'][0]['main'];
    weatherCondition = json['weather'][0]['description'];
    icon = json['weather'][0]['icon'];
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTimeUnix': dateTimeUnix,
      'temperature': temperature,
      'weatherMain': weatherMain,
      'weatherCondition': weatherCondition,
      'icon': icon,
    };
  }
}
