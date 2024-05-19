import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather/core/api/api_services.dart';
import 'package:weather/core/api/data.dart';
import 'package:weather/core/errors/error.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';
import 'package:weather/feature/home/data/repository/home_repository.dart';

class HomeRepositoryImplementation implements HomeRepository {
  final ApiServices apiServices;
  const HomeRepositoryImplementation(this.apiServices);
  @override
  Future<Either<Error, WeatherModel>> fetchWeatherByCityName(
      {required String cityName}) async {
    try {
      Map<String, dynamic> data = await apiServices.get(
        endPoint: Data.forecast,
        queryParameters: {
          'q': cityName,
          'key': Data.apiKey,
          'days': 7,
        },
      );
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      return Right(weatherModel);
    } catch (error) {
      if (error is DioError) {
        return Left(ServerError.fromDioError(error));
      } else {
        return Left(ServerError(error.toString()));
      }
    }
  }

  @override
  Future<Either<Error, WeatherModel>> fetchWeatherByUserLocation({
    required String latitude,
    required String longitude,
  }) async {
    try {
      Map<String, dynamic> data = await apiServices.get(
        endPoint: Data.forecast,
        queryParameters: {
          'q': '$latitude,$longitude',
          'key': Data.apiKey,
          'days': 7,
        },
      );
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      return Right(weatherModel);
    } catch (error) {
      if (error is DioError) {
        return Left(ServerError.fromDioError(error));
      } else {
        return Left(ServerError(error.toString()));
      }
    }
  }


  @override
  Future<Either<Error, List<WeatherModel>>> fetchWeatherForFortyCity({
    required List<String> weatherCitiesName,
  }) async {
    try {
      List<WeatherModel> weatherCities = [];
      for (String cityName in weatherCitiesName) {
        Map<String, dynamic> data = await apiServices.get(
          endPoint: Data.forecast,
          queryParameters: {
            'q': cityName,
            'key': Data.apiKey,
            'days': 7,
          },
        );
          weatherCities.add(WeatherModel.fromJson(data));
      }
      return Right(weatherCities);
    } catch (error) {
      if (error is DioError) {
        return Left(ServerError.fromDioError(error));
      } else {
        return Left(ServerError(error.toString()));
      }
    }
  }
}
