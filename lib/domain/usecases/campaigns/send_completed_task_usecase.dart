import 'package:audaxious/data/repository/auth_repository_impl.dart';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/campaigns_repository_impl.dart';
import '../../models/tasks.dart';
import '../../repository/campaigns_repository.dart';
abstract class SendCompletedTaskUseCase {
  Future<dynamic> sendCompletedTasks(int campaignUUID, List<Task> completedTasks);
}

class SendCompletedTaskUseCaseImpl extends SendCompletedTaskUseCase {
  final CampaignsRepository campaignsRepository;

  SendCompletedTaskUseCaseImpl(this.campaignsRepository);

  @override
  Future sendCompletedTasks(int campaignUUID, List<Task> completedTasks) async {
    return await campaignsRepository.sendCompletedTasks(campaignUUID, completedTasks);
  }
}

final sendCompletedTaskUseCaseProvider = Provider<SendCompletedTaskUseCase>((ref) {
  return SendCompletedTaskUseCaseImpl(ref.read(campaignsRepositoryProvider));
});