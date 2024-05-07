
import 'package:audaxious/domain/models/leader_board.dart';
import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/domain/usecases/spaces/space_detail_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/campaign.dart';
import '../../../domain/usecases/spaces/campaigns_by_space_id_usecase.dart';
import '../../../domain/usecases/spaces/join_space_usecase.dart';
import '../../../domain/usecases/spaces/space_leaderboard_by_space_id_usecase.dart';
import '../../screens/spaces/space_detail_state.dart';
import '../../widgets/alerts/custom_toast.dart';

class SpacesDetailsViewModel extends StateNotifier<SpaceDetailState> {
  SpaceDetailUseCase spaceDetailUseCase;
  CampaignsBySpaceIdUseCase campaignsBySpaceIdUseCase;
  SpaceLeaderBoardBySpaceIdUseCase spaceLeaderBoardBySpaceIdUseCase;
  JoinSpaceUseCase joinSpacesUseCase;

  SpacesDetailsViewModel({
    required this.spaceDetailUseCase,
    required this.campaignsBySpaceIdUseCase,
    required this.spaceLeaderBoardBySpaceIdUseCase,
    required this.joinSpacesUseCase,
  }) : super (SpaceDetailState.initial());

  static final notifier =
  StateNotifierProvider<SpacesDetailsViewModel, SpaceDetailState>((ref) => SpacesDetailsViewModel(
      spaceDetailUseCase: ref.read(spaceDetailsUseCaseProvider),
      campaignsBySpaceIdUseCase: ref.read(campaignsBySpaceIdRepositoryProvider),
      spaceLeaderBoardBySpaceIdUseCase: ref.read(spaceLeaderBoardBySpaceIdRepositoryProvider),
      joinSpacesUseCase: ref.read(joinSpaceUseCaseProvider),
  ));

  Future<Space?> getSpaceDetail(String spaceId) async {
    state = state.update(spaceInfoViewState: ViewState.loading);
    try {
      final response = await spaceDetailUseCase.getSpaceDetails(spaceId);
      final data = response['data'];
      final space = Space.fromJson(data);

      state = state.update(space: space);
      state = state.update(spaceInfoViewState: ViewState.idle);

      return space;

    } catch (e) {
      state = state.update(spaceInfoViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
      return null;
    }
  }

  Future<void> getCampaignsBySpaceId(String spaceId) async {
    state = state.update(spaceCampaignsViewState: ViewState.loading);
    try {
      final response = await campaignsBySpaceIdUseCase.getCampaignsBySpaceId(spaceId);
      final data = response['data'];

      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        final campaigns = dataList.map((spacesData) => Campaign.fromJson(spacesData)).toList();
        state = state.update(campaigns: campaigns);
      }else {
        print('Unexpected data format. Expected a list of spaces.');
        state = state.update(spaceCampaignsViewState: ViewState.error);
        state = state.update(error: "Unexpected data format. Expected a list of spaces");
      }

      state = state.update(spaceCampaignsViewState: ViewState.idle);

    } catch (e) {
      state = state.update(spaceCampaignsViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

  Future<void> getLeaderBoardBySpaceId(String spaceId) async {
    state = state.update(spaceLeaderboardViewState: ViewState.loading);
    try {
      final response = await spaceLeaderBoardBySpaceIdUseCase.getLeaderBoardBySpaceId(spaceId);
      final data = response['data'];
      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        final leaderBoard = dataList.map((leaderBoardData) => LeaderBoard.fromJson(leaderBoardData)).toList();
        state = state.update(leaderBoard: leaderBoard);
      }else {
        print('Unexpected data format. Expected a list of spaces.');
        state = state.update(spaceCampaignsViewState: ViewState.error);
        state = state.update(error: "Unexpected data format. Expected a list of spaces");
      }

      state = state.update(spaceLeaderboardViewState: ViewState.idle);

    } catch (e) {
      state = state.update(spaceLeaderboardViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

  Future<bool> joinSpace(String spaceId, BuildContext context) async {
    state = state.update(joinSpaceViewState: ViewState.loading);
    try {
      final response = await joinSpacesUseCase.joinSpace(spaceId);
      final message = response['message'];

      state = state.update(message: message);
      state = state.update(joinSpaceViewState: ViewState.idle);

      // CustomToast.show(
      //   context: context,
      //   title: "Success",
      //   description: message,
      //   type: ToastificationType.success,
      // );

      return true;

    } catch (e) {
      state = state.update(error: e.toString());
      state = state.update(joinSpaceViewState: ViewState.error);
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


