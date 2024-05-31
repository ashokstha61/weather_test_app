import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/errors/error.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';
import 'package:weather/feature/home/data/repository/home_repository.dart';
import 'package:weather/feature/home/presentation/cubits/weather_cubit/weather_state.dart';

import '../../../../../config/local/weather_cache_manager.dart';

class WeatherCubit extends Cubit<CommonState> {
  WeatherCubit(this.homeRepository) : super(CommonInitialState());

  final HomeRepository homeRepository;

  static WeatherCubit get(context) => BlocProvider.of(context);

  Future<void> fetchWeatherByCityName({
    required String cityName,
  }) async {
    emit(CommonLoadingState());
    // final isCacheValid = await WeatherCacheManager.isCacheValid();
    // if (isCacheValid) {
    //   final cachedWeather = await WeatherCacheManager.getCachedWeatherData();
    //   if (cachedWeather != null) {
    //     emit(CommonSuccessState(cachedWeather));
    //     return;
    //   }
    // }
    try {
      Either<Error, WeatherModel> result =
          await homeRepository.fetchWeatherByCityName(cityName: cityName);
      result.fold(
        (failure) async {
          final isCacheValid = await WeatherCacheManager.isCacheValid();
          if (isCacheValid) {
            final cachedWeather =
                await WeatherCacheManager.getCachedWeatherData();
            if (cachedWeather != null) {
              emit(CommonSuccessState(cachedWeather));
            } else {
              emit(CommonErrorState(failure.error));
            }
          } else {
            emit(CommonErrorState(failure.error));
          }
        },
        (weather) async {
          await WeatherCacheManager.cacheWeatherData(weather);
          emit(CommonSuccessState(weather));
        },
      );
    } catch (e) {
      final isCacheValid = await WeatherCacheManager.isCacheValid();
      if (isCacheValid) {
        final cachedWeather = await WeatherCacheManager.getCachedWeatherData();
        if (cachedWeather != null) {
          emit(CommonSuccessState(cachedWeather));
        } else {
          emit(CommonErrorState('Failed to fetch weather data.'));
        }
      } else {
        emit(CommonErrorState('Failed to fetch weather data.'));
      }
    }
  }

  Future<void> fetchWeatherByUserLocation({
    required String latitude,
    required String longitude,
  }) async {
    emit(CommonLoadingState());
    // final isCacheValid = await WeatherCacheManager.isCacheValid();
    // if (isCacheValid) {
    //   final cachedWeather = await WeatherCacheManager.getCachedWeatherData();
    //   if (cachedWeather != null) {
    //     emit(CommonSuccessState(cachedWeather));
    //     return;
    //   }
    // }
    try {
      Either<Error, WeatherModel> result =
          await homeRepository.fetchWeatherByUserLocation(
        latitude: latitude,
        longitude: longitude,
      );

      result.fold(
        (failure) async {
          final isCacheValid = await WeatherCacheManager.isCacheValid();
          if (isCacheValid) {
            final cachedWeather =
                await WeatherCacheManager.getCachedWeatherData();
            if (cachedWeather != null) {
              emit(CommonSuccessState(cachedWeather));
            } else {
              emit(CommonErrorState(failure.error));
            }
          } else {
            emit(CommonErrorState(failure.error));
          }
        },
        (weather) async {
          await WeatherCacheManager.cacheWeatherData(weather);
          emit(CommonSuccessState(weather));
        },
      );
    } catch (e) {
      final isCacheValid = await WeatherCacheManager.isCacheValid();
      if (isCacheValid) {
        final cachedWeather = await WeatherCacheManager.getCachedWeatherData();
        if (cachedWeather != null) {
          emit(CommonSuccessState(cachedWeather));
        } else {
          emit(CommonErrorState('Failed to fetch weather data.'));
        }
      } else {
        emit(CommonErrorState('Failed to fetch weather data.'));
      }
    }
    // Either<Error, WeatherModel> result =
    //     await homeRepository.fetchWeatherByUserLocation(
    //   latitude: latitude,
    //   longitude: longitude,
    // );
    // result.fold(
    //   (failure) {
    //     emit(CommonErrorState(failure.error));
    //   },
    //   (weather) async {
    //     await WeatherCacheManager.cacheWeatherData(weather);
    //     emit(CommonSuccessState(weather));
    //   },
    // );
  }
}
