import 'package:dio/dio.dart';

abstract class Error {
  final String error;

  const Error(this.error);
}

class ServerError extends Error {
  ServerError(super.error);
  factory ServerError.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return ServerError('Connection timeout with Api Server');
      case DioErrorType.sendTimeout:
        return ServerError('Send timeout with Api Server');
      case DioErrorType.receiveTimeout:
        return ServerError('Receive timeout with Api Server');
      case DioErrorType.response:
        return ServerError.fromDioResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioErrorType.cancel:
        return ServerError('Request to ApiServer was canceled');
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          return ServerError('No Internet Connection');
        } else {
          return ServerError('Unexpected Error, Please try again!');
        }
      default:
        return ServerError('Opps there was an error, Please try again!');
    }
  }

  factory ServerError.fromDioResponse(int statsCode, dynamic response) {
    switch (statsCode) {
      case 401:
      case 402:
      case 403:
        return ServerError(response['error']['message']);
      case 404:
        return ServerError('Your request not found, Please try later!');
      case 500:
        return ServerError('Internal server error, Please try later!');
      default:
        return ServerError(response['error']['message']);
    }
  }
}
