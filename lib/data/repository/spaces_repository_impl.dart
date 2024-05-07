import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/internet_services/dio_client.dart';
import '../../core/services/internet_services/dio_exception.dart';
import '../../core/services/internet_services/endpoints.dart';
import '../../core/services/internet_services/network_connectivity.dart';
import '../../core/services/internet_services/retry_interceptor.dart';

class SpacesRepositoryImpl extends SpacesRepository {
  // final RetryOnConnectionChangeInterceptor _interceptor;
  //
  // SpacesRepositoryImpl() : _interceptor = RetryOnConnectionChangeInterceptor(
  //     requestRetrier: NetworkConnectivityRequestRetrier(
  //         dio: DioClient.instance.dioInstance,
  //         connectivity: Connectivity())) {
  //   DioClient.instance.dioInstance.interceptors.add(_interceptor);
  // }

  @override
  Future<dynamic> getSpaces(bool requiresAuthorization) async {
    try {
      final response = await DioClient.instance.get(
        spacesEndpoint,
        requiresAuthorization: requiresAuthorization
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

