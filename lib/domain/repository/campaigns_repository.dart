import '../models/tasks.dart';

abstract class CampaignsRepository {
  Future<dynamic> getCampaigns();
  Future<dynamic> sendCompletedTasks(int campaignUUID, List<Task> completedTasks);
}
