import 'dart:io';

import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if(_shouldRetryRequest(err)) {

    }

    return err;
  }

  bool _shouldRetryRequest(DioException err) {
    return err.type == DioExceptionType.unknown &&
    err.error != null &&
    err.error is SocketException;
  }
}