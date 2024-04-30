import 'dart:convert';

import 'package:audaxious/domain/models/tasks.dart';
import 'package:audaxious/domain/repository/campaigns_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/internet_services/dio_client.dart';
import '../../core/services/internet_services/dio_exception.dart';
import '../../core/services/internet_services/endpoints.dart';

class CampaignsRepositoryImpl extends CampaignsRepository {
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

