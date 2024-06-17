import 'package:dio/dio.dart';

class CustomDioException implements Exception {
  late String errorMessage;

  CustomDioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage = "Request to server was canceled";
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timeout";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receiving request timeout";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Sending request timeout";
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleBadResponse(dioError.response);
        break;
      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          errorMessage = "No internet connection";
          break;
        }
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
  }

  String _handleBadResponse(Response? response) {
    if (response?.data.containsKey('error')) {
      return response?.data['error'];
    }

    switch (response?.statusCode) {
      case 500:
      case 503:
        return "Oops. Something went wrong. It's not your fault.";
      case 400:
        return "Bad request";
      case 401:
        return "Unauthorized request";
      case 403:
        return "Access denied";
      case 404:
        return "Resource not found";
      default:
        if (response?.data.containsKey('error')) {
          return response?.data['error'];
        }
        return 'Unexpected error occurred';
    }
  }

  @override
  String toString()=> errorMessage;

}