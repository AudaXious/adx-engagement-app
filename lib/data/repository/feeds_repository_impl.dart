import 'package:audaxious/domain/repository/feeds_repository.dart';
import 'package:dio/dio.dart';

import '../../core/services/internet_services/dio_client.dart';
import '../../core/services/internet_services/dio_exception.dart';
import '../../core/services/internet_services/endpoints.dart';

class FeedsRepositoryImpl extends FeedsRepository {
  @override
  Future<Map<String, dynamic>> getFeeds() async {
    try {
      final response = await DioClient.instance.get(
        feedsEndpoint,
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }

  }

}
