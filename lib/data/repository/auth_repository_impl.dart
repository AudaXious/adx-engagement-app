import 'dart:convert';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/internet_services/dio_client.dart';
import '../../core/services/internet_services/dio_exception.dart';
import '../../core/services/internet_services/endpoints.dart';
import '../../core/services/shared_preferences_services.dart';
import '../../domain/models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Map<String, dynamic>> login(String email) async {
    try {
      final response = await DioClient.instance.post(
          loginEndpoint,
          data: {'email': email},
          requiresAuthorization: false
      );

      final data = response['data'];
      if (data != null) {
        User user = User.fromJson(data);
        await SharedPreferencesServices().saveCurrentUser("user", json.encode(user));
        // await SharedPreferencesServices.saveIsLoggedIn(true);
        // await SharedPreferencesServices.saveAccessToken(user.token!);
      }

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<Map<String, dynamic>> verifyOTPForSignIn(String email, String otp) async {
    try {
      final response = await DioClient.instance.post(
          verifyOTPEndpoint,
          data: {'email': email, 'otp': otp},
          requiresAuthorization: false
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<Map<String, dynamic>> createUsername(String username) async {
    try {
      final response = await DioClient.instance.post(
          createUsernameEndpoint,
          data: {'username': username},
          requiresAuthorization: false
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }
  
}

final authRepositoryProvider = Provider<AuthRepository>((ref){
  return AuthRepositoryImpl();
});