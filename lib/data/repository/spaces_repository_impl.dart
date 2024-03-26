import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/internet_services/dio_client.dart';
import '../../core/services/internet_services/dio_exception.dart';
import '../../core/services/internet_services/endpoints.dart';

class SpacesRepositoryImpl extends SpacesRepository {
  @override
  Future<dynamic> getSpaces() async {
    try {
      final response = await DioClient.instance.get(
        spacesEndpoint,
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<dynamic> getUserSpaces() async {
    try {
      final response = await DioClient.instance.get(
        userSpacesEndpoint,
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<dynamic> getSpaceDetails(String spaceId) async {
    try {
      final response = await DioClient.instance.get(
        "$spacesDetailEndpoint/$spaceId",
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future getCampaignsBySpaceId(String spaceId) async {
    try {
      final response = await DioClient.instance.get(
        "$campaignsBySpaceEndpoint/$spaceId/all",
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future joinSpace(String spaceId) async {
    try {
      final response = await DioClient.instance.get(
        "$joinSpaceEndpoint/$spaceId",
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

