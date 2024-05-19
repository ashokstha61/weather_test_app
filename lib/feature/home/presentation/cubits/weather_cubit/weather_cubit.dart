import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/errors/error.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';
import 'package:weather/feature/home/data/repository/home_repository.dart';
import 'package:weather/feature/home/presentation/cubits/weather_cubit/weather_state.dart';


class WeatherCubit extends Cubit<CommonState> {
  WeatherCubit(this.homeRepository) : super(CommonInitialState());

  final HomeRepository homeRepository;

  static WeatherCubit get(context) => BlocProvider.of(context);

  Future<void> fetchWeatherByCityName({
    required String cityName,
  }) async {
    emit(CommonLoadingState());
    Either<Error, WeatherModel> result =
        await homeRepository.fetchWeatherByCityName(cityName: cityName);
    result.fold(
      (failure) {
        emit(CommonErrorState(failure.error));
      },
      (weather) {
        emit(CommonSuccessState(weather));
      },
    );
  }

  Future<void> fetchWeatherByUserLocation({
    required String latitude,
    required String longitude,
  }) async {
    emit(CommonLoadingState());
    Either<Error, WeatherModel> result =
        await homeRepository.fetchWeatherByUserLocation(
      latitude: latitude,
      longitude: longitude,
    );
    result.fold(
      (failure) {
        emit(CommonErrorState(failure.error));
      },
      (weather) {
        emit(CommonSuccessState(weather));
      },
    );
  }
}
