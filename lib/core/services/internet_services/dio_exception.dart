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

  // String _handleBadResponse(int? statusCode) {
  //   switch (statusCode) {
  //     case 400:
  //       return 'Bad request';
  //     case 401:
  //       return 'Unauthorized';
  //     case 403:
  //       return 'The authenticated user is not allowed to access the specified API endpoint';
  //     case 404:
  //       return 'The requested resource does not exist';
  //     case 500:
  //       return 'Internal server error';
  //     default:
  //       return 'Oops something went wrong!';
  //   }
  // }

  String _handleBadResponse(Response? response) {
    if (response != null) {
      if (response.data != null && response.data.containsKey('error')) {
        var errorValue = response.data['error'];
        return errorValue;
      }
    }

    return 'No error message found!';
  }

  @override
  String toString()=> errorMessage;

}