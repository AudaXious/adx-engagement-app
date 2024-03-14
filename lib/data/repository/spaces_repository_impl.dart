import 'package:audaxious/domain/repository/feeds_repository.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/internet_services/dio_client.dart';
import '../../core/services/internet_services/dio_exception.dart';
import '../../core/services/internet_services/endpoints.dart';

class SpacesRepositoryImpl extends SpacesRepository {
  @override
  Future<List<dynamic>> getSpaces() async {
    try {
      final response = await DioClient.instance.get(
        feedsEndpoint,
        requiresAuthorization: false
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

}

final spacesRepositoryProvider = Provider<SpacesRepository>((ref) {
  return SpacesRepositoryImpl();
});

