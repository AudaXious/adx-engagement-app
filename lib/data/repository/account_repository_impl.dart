import 'dart:convert';
import 'package:audaxious/domain/repository/account_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/internet_services/dio_client.dart';
import '../../core/services/internet_services/dio_exception.dart';
import '../../core/services/internet_services/endpoints.dart';
import '../../core/services/internet_services/network_connectivity.dart';
import '../../core/services/internet_services/retry_interceptor.dart';
import '../../core/services/shared_preferences_services.dart';
import '../../domain/models/user.dart';

class AccountRepositoryImpl implements AccountRepository {
  final RetryOnConnectionChangeInterceptor _interceptor;

  AccountRepositoryImpl() : _interceptor = RetryOnConnectionChangeInterceptor(
      requestRetrier: NetworkConnectivityRequestRetrier(
          dio: DioClient.instance.dioInstance,
          connectivity: Connectivity())) {
    DioClient.instance.dioInstance.interceptors.add(_interceptor);
  }

  @override
  Future<User?> getCurrentSavedUserProfile() async {
    try {
      String? userJson = await SharedPreferencesServices().getCurrentSavedUser("user");
      if (userJson != null) {
        dynamic userMap = json.decode(userJson);
        User user = User.fromJson(userMap);
        return user;
      }
    } catch (e) {
      print("Error loading user data: $e");
    }

    return null;
  }

  @override
  Future<dynamic> getCurrentUserProfile() async {
    try {
      final response = await DioClient.instance.post(
        currentSavedUserProfileEndpoint,
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }
}

final accountRepositoryProvider = Provider<AccountRepository>((ref){
  return AccountRepositoryImpl();
});