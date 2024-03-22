
import 'package:audaxious/domain/models/campaign.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/enums/view_state.dart';
import '../../../domain/usecases/campaigns/campaigns_usecase.dart';
import '../../screens/campaigns/campaign_details_state.dart';

class CampaignsViewModel extends StateNotifier<CampaignDetailsState> {
  CampaignsUseCase campaignsUseCase;

  CampaignsViewModel({
    required this.campaignsUseCase,
  }) : super (CampaignDetailsState.initial()) {
    getCampaigns();
  }

  static final notifier =
  StateNotifierProvider<CampaignsViewModel, CampaignDetailsState>((ref) => CampaignsViewModel(
      campaignsUseCase: ref.read(campaignsUseCaseProvider),
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
}


