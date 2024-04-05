
import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/domain/usecases/spaces/space_detail_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/campaign.dart';
import '../../../domain/usecases/spaces/campaigns_by_space_id_usecase.dart';
import '../../../domain/usecases/spaces/join_space_usecase.dart';
import '../../screens/spaces/space_detail_state.dart';

class SpacesDetailsViewModel extends StateNotifier<SpaceDetailState> {
  SpaceDetailUseCase spaceDetailUseCase;
  CampaignsBySpaceIdUseCase campaignsBySpaceIdUseCase;
  JoinSpaceUseCase joinSpacesUseCase;

  SpacesDetailsViewModel({
    required this.spaceDetailUseCase,
    required this.campaignsBySpaceIdUseCase,
    required this.joinSpacesUseCase,
  }) : super (SpaceDetailState.initial()) {
    // getSpaceDetail(spaceId);
  }

  static final notifier =
  StateNotifierProvider<SpacesDetailsViewModel, SpaceDetailState>((ref) => SpacesDetailsViewModel(
      spaceDetailUseCase: ref.read(spaceDetailsUseCaseProvider),
      campaignsBySpaceIdUseCase: ref.read(campaignsBySpaceIdRepositoryProvider),
      joinSpacesUseCase: ref.read(joinSpaceUseCaseProvider),
  ));

  Future<void> getSpaceDetail(String spaceId) async {
    state = state.update(spaceInfoViewState: ViewState.loading);
    try {
      final response = await spaceDetailUseCase.getSpaceDetails(spaceId);
      final data = response['data'];
      print(data);
      final space = Space.fromJson(data);

      state = state.update(space: space);
      state = state.update(spaceInfoViewState: ViewState.idle);

    } catch (e) {
      state = state.update(spaceInfoViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

  Future<void> getCampaignsBySpaceId(String spaceId) async {
    state = state.update(spaceCampaignsViewState: ViewState.loading);
    try {
      final response = await campaignsBySpaceIdUseCase.getCampaignsBySpaceId(spaceId);
      final data = response['data'];
      print(data);
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

  Future<bool> joinSpace(String spaceId) async {
    state = state.update(joinSpaceViewState: ViewState.loading);
    try {
      final response = await joinSpacesUseCase.joinSpace(spaceId);
      final data = response['data'];
      final message = response['message'];
      print(message);

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

}


