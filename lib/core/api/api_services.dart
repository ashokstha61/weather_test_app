import 'package:dio/dio.dart';
import 'package:weather/core/api/data.dart';

abstract class ApiServices {
  Future<Map<String, dynamic>> get({
    required String endPoint,
    required Map<String, dynamic> queryParameters,
  });
}

class ApiImplementation implements ApiServices {
  Dio _dio = Dio();
  ApiImplementation() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Data.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 10 * 1000, //10 second
      receiveTimeout: 10 * 1000,
    );
    _dio = Dio(baseOptions);
  }
  @override
  Future<Map<String, dynamic>> get({
    required String endPoint,
    required Map<String, dynamic> queryParameters,
  }) async {
    Response response =
        await _dio.get(endPoint, queryParameters: queryParameters);
    return response.data;
  }
}
