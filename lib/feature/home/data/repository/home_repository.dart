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
      // Cache weather data
//       await WeatherCacheManager.cacheWeatherData(WeatherModel());

// // Get cached weather data
//       final cachedWeather = await WeatherCacheManager.getCachedWeatherData();

// // Check if cache is valid
//       final isValid = await WeatherCacheManager.isCacheValid();

      // var isCacheExists = await APICacheManager().isAPICacheKeyExist("Weather");
      // if (isCacheExists) {
      //   var cacheData = await APICacheManager().getCacheData("Weather");
      //   var model = json.decode(cacheData.syncData);
      //   return Right(model);
      // }
      // var res = await dio.get(apiServices.get(
      //   endPoint: Data.forecast,
      //   queryParameters: {
      //     'q': cityName,
      //     'key': Data.apiKey,
      //     'days': 7,
      //   },
      // ).toString());
      // if (res.statusCode == 200) {
      //   APICacheDBModel cacheDBModel =
      //       APICacheDBModel(key: "Weather", syncData: json.encode(res.data));
      //   await APICacheManager().addCacheData(cacheDBModel);
      //   var model = WeatherModel.fromJson(res.data);
      //   if (model.location != null) {
      //     var Weatherist = model.location!;

      //     weather.clear();
      //     weather.add(Weatherist);
      //     return Right(model);
      //   } else {
      //     return Right([] as WeatherModel);
      //   }
      // } else {
      //   return Right(null);

      // }
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

// Get cached weather data
//       final cachedWeather = await WeatherCacheManager.getCachedWeatherData();

// // Check if cache is valid
//       final isValid = await WeatherCacheManager.isCacheValid();

      // var isCacheExists = await APICacheManager().isAPICacheKeyExist("Weather");
      // if (isCacheExists) {
      //   var cacheData = await APICacheManager().getCacheData("Weather");
      //   var model = json.decode(cacheData.syncData);
      //   return Right(model);
      // }
      // var res = await dio.get(apiServices.get(
      //   endPoint: Data.forecast,
      //   queryParameters: {
      //     'q': '$latitude,$longitude',
      //     'key': Data.apiKey,
      //     'days': 7,
      //   },
      // ).toString());
      Map<String, dynamic> data = await apiServices.get(
        endPoint: Data.forecast,
        queryParameters: {
          'q': '$latitude,$longitude',
          'key': Data.apiKey,
          'days': 7,
        },
      );
      // if (res.statusCode == 200) {
      //   APICacheDBModel cacheDBModel =
      //       APICacheDBModel(key: "Weather", syncData: json.encode(res.data));
      // }
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

  // Future<Either<Error, List<WeatherModel>>> fetchWeatherForFortyCity({
  //   required List<String> weatherCitiesName,
  // }) async {
  //   try {
  //     List<WeatherModel> weatherCities = [];
  //     for (String cityName in weatherCitiesName) {
  //       Map<String, dynamic> data = await apiServices.get(
  //         endPoint: Data.forecast,
  //         queryParameters: {
  //           'q': cityName,
  //           'key': Data.apiKey,
  //           'days': 7,
  //         },
  //       );
  //       weatherCities.add(WeatherModel.fromJson(data));
  //     }
  //     return Right(weatherCities);
  //   } catch (error) {
  //     if (error is DioError) {
  //       return Left(ServerError.fromDioError(error));
  //     } else {
  //       return Left(ServerError(error.toString()));
  //     }
  //   }
  // }
}
