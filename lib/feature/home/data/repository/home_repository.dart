import 'package:dartz/dartz.dart';
import 'package:weather/core/errors/error.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';

abstract class HomeRepository {
  Future<Either<Error, WeatherModel>> fetchWeatherByCityName({
    required String cityName,
  });

  Future<Either<Error, WeatherModel>> fetchWeatherByUserLocation({
    required String latitude,
    required String longitude,
  });

  // Future<Either<Failure, WeatherModel>> fetchWeatherByWeatherName({
  //   required List<String> weatherCitiesName,
  //   required String weatherNameOne,
  //   required String weatherNameTwo,
  // });

  // Future<Either<Failure, WeatherModel>> fetchWeatherByMultipleWeatherName({
  //   required List<String> weatherCitiesName,
  //   required String weatherNameOne,
  //   required String weatherNameTwo,
  //   required String weatherNameThree,
  //   required String weatherNameFour,
  //   required String weatherNameFive,
  // });
  Future<Either<Error, List<WeatherModel>>> fetchWeatherForFortyCity({
    required List<String> weatherCitiesName,
  });
}
