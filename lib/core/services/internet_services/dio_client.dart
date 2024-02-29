import 'package:dio/dio.dart';
import '../shared_preferences_services.dart';
import 'endpoints.dart';

class DioClient {
  DioClient._();

  static final instance = DioClient._();
  final Dio _dio = Dio(BaseOptions(
    baseUrl: audaxiousBaseURL,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    responseType: ResponseType.json,
  ));

  //GET METHOD
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool requiresAuthorization = true,
      }) async {
    try {
      if (requiresAuthorization) {
        final accessToken = await SharedPreferencesServices.getAccessToken();
        options = options ?? Options();
        options.headers = {'Authorization': 'Bearer $accessToken'};
      }

      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200) {
        print("Feeds: ${response.data}");
        return response.data;
      }

      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  //POST METHOD
  Future<dynamic> post(
      String path, {
        data,
        Map<String, dynamic>? queryParameter,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool requiresAuthorization = true,
      }) async {
    try {
      if (requiresAuthorization) {
        final accessToken = await SharedPreferencesServices.getAccessToken();
        options = options ?? Options();
        options.headers = {'Authorization': 'Bearer $accessToken'};
      }

      final Response response = await _dio.post(path,
          data: data,
          queryParameters: queryParameter,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }

      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<dynamic> put(
      String path, {
        Map<String, dynamic>? queryParameters,
        data,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiverProgress,
        bool requiresAuthorization = true,
      }) async {
    try {
      if (requiresAuthorization) {
        final accessToken = await SharedPreferencesServices.getAccessToken();
        options = options ?? Options();
        options.headers = {'Authorization': 'Bearer $accessToken'};
      }

      final Response response = await _dio.put(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiverProgress);

      if (response.statusCode == 200) {
        return response.data;
      }

      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<dynamic> patch(
      String path, {
        Map<String, dynamic>? queryParameters,
        data,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiverProgress,
        bool requiresAuthorization = true,
      }) async {
    try {
      if (requiresAuthorization) {
        final accessToken = await SharedPreferencesServices.getAccessToken();
        options = options ?? Options();
        options.headers = {'Authorization': 'Bearer $accessToken'};
      }

      final Response response = await _dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiverProgress);

      if (response.statusCode == 200) {
        return response.data;
      }

      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  //DELETE METHOD
  Future<dynamic> delete(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        bool requiresAuthorization = true,
      }) async {
    try {
      if (requiresAuthorization) {
        final accessToken = await SharedPreferencesServices.getAccessToken();
        options = options ?? Options();
        options.headers = {'Authorization': 'Bearer $accessToken'};
      }

      final Response response = await _dio.delete(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

      if (response.statusCode == 204) {
        return response.data;
      }

      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }
}