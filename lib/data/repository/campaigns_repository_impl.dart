import 'dart:convert';

import 'package:audaxious/domain/models/tasks.dart';
import 'package:audaxious/domain/repository/campaigns_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/internet_services/dio_client.dart';
import '../../core/services/internet_services/dio_exception.dart';
import '../../core/services/internet_services/endpoints.dart';
import '../../core/services/internet_services/network_connectivity.dart';
import '../../core/services/internet_services/retry_interceptor.dart';

class CampaignsRepositoryImpl extends CampaignsRepository {
  // final RetryOnConnectionChangeInterceptor _interceptor;
  //
  // CampaignsRepositoryImpl() : _interceptor = RetryOnConnectionChangeInterceptor(
  //     requestRetrier: NetworkConnectivityRequestRetrier(
  //         dio: DioClient.instance.dioInstance,
  //         connectivity: Connectivity())) {
  //   DioClient.instance.dioInstance.interceptors.add(_interceptor);
  // }

  @override
  Future<dynamic> getCampaigns() async {
    try {
      final response = await DioClient.instance.get(
        campaignsEndpoint,
      );

      return response;
    } on DioException catch (e) {
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future sendCompletedTasks(int campaignUUID, List<Task> completedTasks) async {
    try {
      // List<Map<String, dynamic>> tasksJsonList =
      // completedTasks.map((task) => task.toJson()).toList();
      // Map<String, dynamic> requestData = {'tasks': tasksJsonList};
      String jsonData = jsonEncode({"tasks": completedTasks});


      final response = await DioClient.instance.post(
        "$sendCompletedTaskEndpoint/$campaignUUID",
        // data: {'tasks': email},

        data: jsonData,
      );

      return response;
    } on DioException catch (e) {
      print("respository eror $e");
      var error = CustomDioException.fromDioError(e);
      throw error.errorMessage;
    }
  }


}

final campaignsRepositoryProvider = Provider<CampaignsRepository>((ref) {
  return CampaignsRepositoryImpl();
});

