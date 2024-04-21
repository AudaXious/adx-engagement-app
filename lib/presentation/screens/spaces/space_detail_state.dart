import 'package:audaxious/domain/models/campaign.dart';
import 'package:audaxious/domain/models/space.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/leader_board.dart';

class SpaceDetailState {
  factory SpaceDetailState.initial() => const SpaceDetailState._(
    spaceInfoViewState: ViewState.idle,
    spaceCampaignsViewState: ViewState.idle,
    spaceLeaderboardViewState: ViewState.idle,
    joinSpaceViewState: ViewState.idle,
    error: '',
    message: '',
    space: null,
    campaigns: null,
    leaderBoard: null,
  );

  const SpaceDetailState._({
    required this.spaceInfoViewState,
    required this.spaceCampaignsViewState,
    required this.spaceLeaderboardViewState,
    required this.joinSpaceViewState,
    required this.error,
    required this.message,
    required this.space,
    required this.campaigns,
    required this.leaderBoard,
  });

  final ViewState spaceInfoViewState;
  final ViewState spaceCampaignsViewState;
  final ViewState spaceLeaderboardViewState;
  final ViewState joinSpaceViewState;
  final String error;
  final String message;
  final Space? space;
  final List<Campaign>? campaigns;
  final List<LeaderBoard>? leaderBoard;

  SpaceDetailState update({
    ViewState? spaceInfoViewState,
    ViewState? spaceCampaignsViewState,
    ViewState? spaceLeaderboardViewState,
    ViewState? joinSpaceViewState,
    String? error,
    String? message,
    Space? space,
    List<Campaign>? campaigns,
    List<LeaderBoard>? leaderBoard,

  }) =>
      SpaceDetailState._(
        spaceInfoViewState: spaceInfoViewState ?? this.spaceInfoViewState,
        spaceCampaignsViewState: spaceCampaignsViewState ?? this.spaceCampaignsViewState,
        spaceLeaderboardViewState: spaceLeaderboardViewState ?? this.spaceLeaderboardViewState,
        joinSpaceViewState: joinSpaceViewState ?? this.joinSpaceViewState,
        error: error ?? this.error,
        message: message ?? this.message,
        space: space ?? this.space,
        campaigns: campaigns ?? this.campaigns,
        leaderBoard: leaderBoard ?? this.leaderBoard,
      );
}

