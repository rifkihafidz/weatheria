import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatheria/models/weather_model.dart';
import 'package:weatheria/services/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  void fetchLocationWeather() async {
    try {
      emit(WeatherLoading());

      WeatherModel weatherModel = await WeatherService().getLocationWeather();

      emit(WeatherSuccess(weatherModel));
    } catch (e) {
      emit(WeatherFailed(e.toString()));
    }
  }
}
