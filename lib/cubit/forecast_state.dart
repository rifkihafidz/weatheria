part of 'forecast_cubit.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastSuccess extends ForecastState {
  final List<ForecastModel> forecast;

  ForecastSuccess(this.forecast);

  @override
  List<Object> get props => [forecast];
}

class ForecastFailed extends ForecastState {
  final String error;

  ForecastFailed(this.error);

  @override
  List<Object> get props => [error];
}
