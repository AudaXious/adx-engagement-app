import 'package:audaxious/domain/models/space.dart';

import '../../../domain/enums/view_state.dart';

class SpaceDetailState {
  factory SpaceDetailState.initial() => const SpaceDetailState._(
    spaceInfoViewState: ViewState.idle,
    spaceCampaignsViewState: ViewState.idle,
    spaceLeaderboardViewState: ViewState.idle,
    error: '',
    space: null
  );
  const SpaceDetailState._({
    required this.spaceInfoViewState,
    required this.spaceCampaignsViewState,
    required this.spaceLeaderboardViewState,
    required this.error,
    required this.space,
  });

  final ViewState spaceInfoViewState;
  final ViewState spaceCampaignsViewState;
  final ViewState spaceLeaderboardViewState;
  final String error;
  final Space? space;

  SpaceDetailState update({
    ViewState? spaceInfoViewState,
    ViewState? spaceCampaignsViewState,
    ViewState? spaceLeaderboardViewState,
    String? error,
    Space? space

  }) =>
      SpaceDetailState._(
        spaceInfoViewState: spaceInfoViewState ?? this.spaceInfoViewState,
        spaceCampaignsViewState: spaceCampaignsViewState ?? this.spaceCampaignsViewState,
        spaceLeaderboardViewState: spaceLeaderboardViewState ?? this.spaceLeaderboardViewState,
        error: error ?? this.error,
        space: space ?? this.space,
      );
}

