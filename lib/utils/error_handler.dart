import 'dart:io';
import 'package:dio/dio.dart';

class NetworkExceptions {
  static String getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return 'Request cancelled';

            case DioErrorType.receiveTimeout:
              return 'Request timed out';
            case DioErrorType.badResponse:
              if (error.response!.data['message'] is List) {
                return error.response!.data['message'][0];
              }
              return error.response!.data['message'];
            case DioErrorType.sendTimeout:
              return 'Request timed out';
            case DioErrorType.connectionTimeout:
              return 'Connection timed out!';
            case DioErrorType.badCertificate:
              return 'Dont have the right authorization';

            case DioErrorType.connectionError:
              return 'Error in connecting';
            case DioErrorType.unknown:
              return 'Something went wrong!';
          }
        } else if (error is SocketException) {
          return 'No internet connection!';
        } else {
          return 'Unexpected error occured';
        }
      } on FormatException {
        return 'Bad response format';
      } catch (_) {
        return 'Unexpected error occured';
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return 'Unexpected error occured';
      } else {
        return 'Unexpected error occured';
      }
    }
  }
}
