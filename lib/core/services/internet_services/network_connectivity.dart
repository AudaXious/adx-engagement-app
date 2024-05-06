import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class NetworkConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;
  final Duration retryTimeout;

  NetworkConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
    this.retryTimeout = const Duration(seconds: 60)
  });

  Future<dynamic> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();
    bool retried = false;

    streamSubscription = connectivity.onConnectivityChanged.listen(
        (connectivityResults) {
          for (var connectivityResult in connectivityResults) {
            if(connectivityResult != ConnectivityResult.none && !retried){
              retried = true;
              streamSubscription.cancel();
              responseCompleter.complete(
                  dio.request(
                    requestOptions.path,
                    cancelToken: requestOptions.cancelToken,
                    data: requestOptions.data,
                    onReceiveProgress: requestOptions.onReceiveProgress,
                    onSendProgress: requestOptions.onSendProgress,
                    queryParameters: requestOptions.queryParameters,
                  ),
              );
            }
          }
        }
    );

    Future.delayed(retryTimeout, () {
      if (!responseCompleter.isCompleted) {
        retried = true;
        streamSubscription.cancel();
        responseCompleter.completeError('Retry timeout');
      }
    });

    return responseCompleter.future;
  }
}