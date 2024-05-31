// import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/core/api/api_services.dart';
import 'package:weather/feature/home/data/repository/home_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiImplementation>(ApiImplementation());
  getIt.registerSingleton<HomeRepository>(HomeRepository(
    getIt.get<ApiImplementation>(),
    // getIt.get(),
  ));
}
