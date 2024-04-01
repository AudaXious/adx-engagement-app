import 'package:audaxious/domain/models/campaign.dart';

import '../../../domain/enums/view_state.dart';

class CampaignDetailsState {
  factory CampaignDetailsState.initial() => const CampaignDetailsState._(
    viewState: ViewState.idle,
    joinSpaceViewState: ViewState.idle,
    error: '',
      message: '',
    campaigns: null
  );
  const CampaignDetailsState._({
    required this.viewState,
    required this.joinSpaceViewState,
    required this.error,
    required this.message,
    required this.campaigns,
  });

  final ViewState viewState;
  final ViewState joinSpaceViewState;
  final String error;
  final String message;
  final List<Campaign>? campaigns;

  CampaignDetailsState update({
    ViewState? viewState,
    ViewState? joinSpaceViewState,
    String? error,
    String? message,
    List<Campaign>? campaigns

  }) =>
      CampaignDetailsState._(
        viewState: viewState ?? this.viewState,
        joinSpaceViewState: joinSpaceViewState ?? this.joinSpaceViewState,
        error: error ?? this.error,
        message: message ?? this.message,
        campaigns: campaigns ?? this.campaigns,
      );
}

