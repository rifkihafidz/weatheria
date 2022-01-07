import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatheria/models/forecast_model.dart';
import 'package:weatheria/services/forecast_service.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastInitial());

  void fetchForecast() async {
    try {
      emit(ForecastLoading());

      List<ForecastModel> forecasts = await ForecastService().getForecast();

      emit(ForecastSuccess(forecasts));
    } catch (e) {
      emit(ForecastFailed(e.toString()));
    }
  }
}
