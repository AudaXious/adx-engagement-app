
import 'package:audaxious/domain/models/campaign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../../domain/enums/view_state.dart';
import '../../../domain/models/space.dart';
import '../../../domain/models/tasks.dart';
import '../../../domain/usecases/campaigns/campaigns_usecase.dart';
import '../../../domain/usecases/campaigns/send_completed_task_usecase.dart';
import '../../../domain/usecases/spaces/join_space_usecase.dart';
import '../../../domain/usecases/spaces/user_joined_spaces_usecase.dart';
import '../../screens/campaigns/campaign_details_state.dart';
import '../../widgets/alerts/custom_toast.dart';

class CampaignsViewModel extends StateNotifier<CampaignDetailsState> {
  CampaignsUseCase campaignsUseCase;
  JoinSpaceUseCase joinSpacesUseCase;
  UserJoinedSpacesUseCase userJoinedSpacesUseCase;
  SendCompletedTaskUseCase sendCompletedTaskUseCase;

  CampaignsViewModel({
    required this.campaignsUseCase,
    required this.joinSpacesUseCase,
    required this.userJoinedSpacesUseCase,
    required this.sendCompletedTaskUseCase,
  }) : super (CampaignDetailsState.initial());

  static final notifier =
  StateNotifierProvider<CampaignsViewModel, CampaignDetailsState>((ref) => CampaignsViewModel(
    campaignsUseCase: ref.read(campaignsUseCaseProvider),
    joinSpacesUseCase: ref.read(joinSpaceUseCaseProvider),
    userJoinedSpacesUseCase: ref.read(userJoinedSpacesUseCaseProvider),
    sendCompletedTaskUseCase: ref.read(sendCompletedTaskUseCaseProvider),
  ));

  Future<void> getCampaigns() async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await campaignsUseCase.getCampaigns();
      final data = response['data'];

      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        getUserJoinedSpaces();

        final campaigns = dataList.map((spacesData) => Campaign.fromJson(spacesData)).toList();
        state = state.update(campaigns: campaigns);
      }else {
        print('Unexpected data format. Expected a list of spaces.');
        state = state.update(viewState: ViewState.error);
        state = state.update(error: "Unexpected data format. Expected a list of spaces");
      }


    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

  Future<void> getUserJoinedSpaces() async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await userJoinedSpacesUseCase.getUserJoinedSpaces();
      final data = response['data'];
      print(data);

      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        final spaces = dataList.map((spacesData) => Space.fromJson(spacesData)).toList();
        if (spaces.isNotEmpty) {
          final List<String?> spaceUUIDs = spaces.map((space) => space.uuid).toList();
          state = state.update(spaceUUIds: spaceUUIDs);
        }
      } else {
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

  Future<bool> sendCompletedTasks(BuildContext context, int campaignUUID, List<Task> completedTasks) async {
    state = state.update(sendCompletedTaskViewState: ViewState.loading);
    try {
      final response = await sendCompletedTaskUseCase.sendCompletedTasks(campaignUUID, completedTasks);
      final data = response['data'];
      final message = response['message'];
      print(response);

      CustomToast.show(
        context: context,
        title: "Success",
        description: message,
        type: ToastificationType.success,
      );

      state = state.update(sendCompletedTaskViewState: ViewState.idle);
      state = state.update(message: message);

      return true;

    } catch (e) {
      state = state.update(sendCompletedTaskViewState: ViewState.error);
      state = state.update(error: e.toString());
      CustomToast.show(
        context: context,
        title: "Error",
        description: e.toString(),
        type: ToastificationType.error,
      );
      print("View model error: ${e.toString()}");
      return false;
    }
  }

}


