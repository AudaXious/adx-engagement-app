
import 'package:audaxious/domain/models/campaign.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/enums/view_state.dart';
import '../../../domain/models/tasks.dart';
import '../../../domain/usecases/campaigns/campaigns_usecase.dart';
import '../../../domain/usecases/campaigns/send_completed_task_usecase.dart';
import '../../../domain/usecases/spaces/join_space_usecase.dart';
import '../../screens/campaigns/campaign_details_state.dart';

class CampaignsViewModel extends StateNotifier<CampaignDetailsState> {
  CampaignsUseCase campaignsUseCase;
  JoinSpaceUseCase joinSpacesUseCase;
  SendCompletedTaskUseCase sendCompletedTaskUseCase;

  CampaignsViewModel({
    required this.campaignsUseCase,
    required this.joinSpacesUseCase,
    required this.sendCompletedTaskUseCase,
  }) : super (CampaignDetailsState.initial());

  static final notifier =
  StateNotifierProvider<CampaignsViewModel, CampaignDetailsState>((ref) => CampaignsViewModel(
    campaignsUseCase: ref.read(campaignsUseCaseProvider),
    joinSpacesUseCase: ref.read(joinSpaceUseCaseProvider),
    sendCompletedTaskUseCase: ref.read(sendCompletedTaskUseCaseProvider),
  ));

  Future<void> getCampaigns() async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await campaignsUseCase.getCampaigns();
      final data = response['data'];

      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        final campaigns = dataList.map((spacesData) => Campaign.fromJson(spacesData)).toList();
        state = state.update(campaigns: campaigns);
      }else {
        print('Unexpected data format. Expected a list of spaces.');
        state = state.update(viewState: ViewState.error);
        state = state.update(error: "Unexpected data format. Expected a list of spaces");
      }

      state = state.update(viewState: ViewState.idle);

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

  Future<bool> joinSpace(String spaceId) async {
    state = state.update(joinSpaceViewState: ViewState.loading);
    try {
      final response = await joinSpacesUseCase.joinSpace(spaceId);
      final data = response['data'];
      final message = response['message'];

      state = state.update(joinSpaceViewState: ViewState.idle);
      state = state.update(message: message);

      return true;

    } catch (e) {
      state = state.update(joinSpaceViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
      return false;
    }
  }

  Future<bool> sendCompletedTasks(int campaignUUID, List<Task> completedTasks) async {
    state = state.update(sendCompletedTaskViewState: ViewState.loading);
    try {
      final response = await sendCompletedTaskUseCase.sendCompletedTasks(campaignUUID, completedTasks);
      final data = response['data'];
      final message = response['message'];
      print(response);

      state = state.update(sendCompletedTaskViewState: ViewState.idle);
      state = state.update(message: message);

      return true;

    } catch (e) {
      state = state.update(sendCompletedTaskViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
      return false;
    }
  }

}


