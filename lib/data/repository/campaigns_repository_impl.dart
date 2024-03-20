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

}

final campaignsRepositoryProvider = Provider<CampaignsRepository>((ref) {
  return CampaignsRepositoryImpl();
});

