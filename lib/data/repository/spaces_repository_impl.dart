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
  Future<dynamic> getUserCreatedSpaces() async {
    try {
      final response = await DioClient.instance.get(
        userCreatedSpacesEndpoint,
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
  Future<dynamic> getCampaignsBySpaceId(String spaceId) async {
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
  Future<dynamic> getLeaderBoardBySpaceId(String spaceId) async {
    try {
      final response = await DioClient.instance.get(
        "$spaceLeaderBoardEndpoint/$spaceId",
      );

      print(response);
      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<dynamic> joinSpace(String spaceId) async {
    try {
      final response = await DioClient.instance.post(
        "$joinSpaceEndpoint/$spaceId",
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future getUserJoinedSpaces() async {
    try {
      final response = await DioClient.instance.get(
        userJoinedSpacesEndpoint,
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

