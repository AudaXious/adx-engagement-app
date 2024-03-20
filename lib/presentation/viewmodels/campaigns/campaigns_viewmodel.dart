
import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/usecases/feeds/feeds_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/enums/view_state.dart';
import '../../screens/campaigns/post_details_state.dart';

class CampaignsViewModel extends StateNotifier<CampaignDetailsState> {
  FeedsUseCase feedsUseCase;

  CampaignsViewModel({
    required this.feedsUseCase,
  }) : super (CampaignDetailsState.initial()) {
    getFeeds();
  }

  static final notifier =
  StateNotifierProvider<CampaignsViewModel, CampaignDetailsState>((ref) => CampaignsViewModel(
      feedsUseCase: ref.read(feedsUseCaseProvider),
  ));

  Future<void> getFeeds() async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await feedsUseCase.getFeeds();

      final List<Map<String, dynamic>> dataList = response.cast<Map<String, dynamic>>();

      final feeds = dataList
          .map((feedsData) => Campaign.fromJson(feedsData))
          .toList();
      state = state.update(campaigns: feeds);

      state = state.update(viewState: ViewState.idle);

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }
}


