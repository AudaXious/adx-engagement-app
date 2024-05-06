import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class NetworkConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  NetworkConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<dynamic> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
        (connectivityResults) {
          for (var connectivityResult in connectivityResults) {
            if(connectivityResult != ConnectivityResult.none){
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

    return responseCompleter.future;

  }
}