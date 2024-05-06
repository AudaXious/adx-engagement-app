import 'dart:io';

import 'package:audaxious/core/services/internet_services/network_connectivity.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final NetworkConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if(_shouldRetryRequest(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      }catch(e) {
        return e;
      }
    }
    return err;
  }

  bool _shouldRetryRequest(DioException err) {
    return err.type == DioExceptionType.unknown &&
    err.error != null &&
    err.error is SocketException;
  }
}