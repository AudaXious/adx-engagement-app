import 'package:audaxious/domain/models/campaign.dart';

import '../../../domain/enums/view_state.dart';

class CampaignDetailsState {
  factory CampaignDetailsState.initial() => const CampaignDetailsState._(
    viewState: ViewState.idle,
    joinSpaceViewState: ViewState.idle,
    spaceViewState: ViewState.idle,
    sendCompletedTaskViewState: ViewState.idle,
    error: '',
    message: '',
    campaigns: null,
    spaceUUIds: null,
  );
  const CampaignDetailsState._({
    required this.viewState,
    required this.joinSpaceViewState,
    required this.spaceViewState,
    required this.sendCompletedTaskViewState,
    required this.error,
    required this.message,
    required this.campaigns,
    required this.spaceUUIds,
  });

  final ViewState viewState;
  final ViewState joinSpaceViewState;
  final ViewState spaceViewState;
  final ViewState sendCompletedTaskViewState;
  final String error;
  final String message;
  final List<Campaign>? campaigns;
  final List<String?>? spaceUUIds;


  CampaignDetailsState update({
    ViewState? viewState,
    ViewState? joinSpaceViewState,
    ViewState? spaceViewState,
    ViewState? sendCompletedTaskViewState,
    String? error,
    String? message,
    List<Campaign>? campaigns,
    List<String?>? spaceUUIds,

  }) =>
      CampaignDetailsState._(
        viewState: viewState ?? this.viewState,
        joinSpaceViewState: joinSpaceViewState ?? this.joinSpaceViewState,
        spaceViewState: spaceViewState ?? this.spaceViewState,
        sendCompletedTaskViewState: sendCompletedTaskViewState ?? this.sendCompletedTaskViewState,
        error: error ?? this.error,
        message: message ?? this.message,
        campaigns: campaigns ?? this.campaigns,
        spaceUUIds: spaceUUIds ?? this.spaceUUIds,
      );
}

