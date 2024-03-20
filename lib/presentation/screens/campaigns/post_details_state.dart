import 'package:audaxious/domain/models/feed.dart';

import '../../../domain/enums/view_state.dart';

class CampaignDetailsState {
  factory CampaignDetailsState.initial() => const CampaignDetailsState._(
    viewState: ViewState.idle,
    error: '',
    campaigns: null
  );
  const CampaignDetailsState._({
    required this.viewState,
    required this.error,
    required this.campaigns,
  });

  final ViewState viewState;
  final String error;
  final List<Campaign>? campaigns;

  CampaignDetailsState update({
    ViewState? viewState,
    String? error,
    List<Campaign>? campaigns

  }) =>
      CampaignDetailsState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        campaigns: campaigns ?? this.campaigns,
      );
}

