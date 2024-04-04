
import 'package:audaxious/domain/models/campaign.dart';
import 'package:audaxious/domain/usecases/campaigns/campaigns_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../screens/main/home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  CampaignsUseCase campaignsUseCase;

  HomeViewModel({
    required this.campaignsUseCase,
  }) : super (HomeState.initial()) {
    getCampaigns();
  }

  static final notifier =
  StateNotifierProvider<HomeViewModel, HomeState>((ref) => HomeViewModel(
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

  void filterCampaignsByTitle(String query) {
    if (query.isEmpty) {
      state = state.update(filteredCampaigns: state.campaigns);
    } else {
      final filteredCampaigns = state.campaigns?.where((campaign) =>
          campaign.title!.toLowerCase().contains(query.toLowerCase())).toList();

      if (filteredCampaigns != null && filteredCampaigns.isNotEmpty) {
        state = state.update(filteredCampaigns: filteredCampaigns);
      } else {
        state = state.update(filteredCampaigns: []);
      }
    }
  }
}


