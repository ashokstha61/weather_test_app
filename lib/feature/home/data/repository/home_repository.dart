// import 'dart:convert';

// import 'package:api_cache_manager/api_cache_manager.dart';
// import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather/config/local/weather_cache_manager.dart';
import 'package:weather/core/api/api_services.dart';
import 'package:weather/core/api/data.dart';
import 'package:weather/core/errors/error.dart';
// import 'package:weather/feature/home/data/models/weather_model/location.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';

class HomeRepository {
  final ApiServices apiServices;
  // List<WeatherModel> weather = [];
  // final Dio dio;
  HomeRepository(
    this.apiServices,
    // this.dio,
  );

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
    } catch (e) {
      if (e is DioError) {
        return Left(ServerError.fromDioError(e));
      } else {
        return Left(ServerError(e.toString()));
      }
    }
  }

  Future<Either<Error, WeatherModel>> fetchWeatherByUserLocation({
    required String latitude,
    required String longitude,
  }) async {
    try {
      // Cache weather data
      await WeatherCacheManager.cacheWeatherData(WeatherModel());

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

}
