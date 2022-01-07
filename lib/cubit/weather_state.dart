part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final WeatherModel weather;

  WeatherSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}

class WeatherFailed extends WeatherState {
  final String error;

  WeatherFailed(this.error);

  @override
  List<Object> get props => [error];
}
