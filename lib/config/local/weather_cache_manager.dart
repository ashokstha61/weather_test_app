import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';

class WeatherCacheManager {
  static const String _weatherCacheKey = 'weatherCache';
  static const String _cacheTimeKey = 'cacheTime';
  static const Duration cacheDuration = Duration(minutes: 5);

  
  static Future<void> cacheWeatherData(WeatherModel weatherModel) async {
    final pref = await SharedPreferences.getInstance();
    final weatherJson = jsonEncode(weatherModel.toJson());
    await pref.setString(_weatherCacheKey, weatherJson);
    await pref.setString(_cacheTimeKey, DateTime.now().toIso8601String());
  }

  
  static Future<WeatherModel?> getCachedWeatherData() async {
    final pref = await SharedPreferences.getInstance();
    final weatherJson = pref.getString(_weatherCacheKey);
    if (weatherJson != null) {
      final Map<String, dynamic> weatherMap = jsonDecode(weatherJson);
      return WeatherModel.fromJson(weatherMap);
    }
    return null;
  }

  
  static Future<bool> isCacheValid() async {
    final pref = await SharedPreferences.getInstance();
    final cacheTimeString = pref.getString(_cacheTimeKey);
    if (cacheTimeString != null) {
      final cacheTime = DateTime.parse(cacheTimeString);
      return DateTime.now().difference(cacheTime) < cacheDuration;
    }
    return false;
  }
}