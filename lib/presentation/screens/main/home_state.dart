import 'package:audaxious/domain/models/campaign.dart';
import 'package:audaxious/domain/models/user.dart';

import '../../../domain/enums/view_state.dart';

class HomeState {
  factory HomeState.initial() => const HomeState._(
    viewState: ViewState.idle,
    error: '',
    campaigns: null,
    user: null,
    filteredCampaigns: null,
  );
  const HomeState._({
    required this.viewState,
    required this.error,
    required this.campaigns,
    required this.user,
    required this.filteredCampaigns,
  });

  final ViewState viewState;
  final String error;
  final List<Campaign>? campaigns;
  final User? user;
  final List<Campaign>? filteredCampaigns;

  HomeState update({
    ViewState? viewState,
    String? error,
    List<Campaign>? campaigns,
    User? user,
    List<Campaign>? filteredCampaigns,
  }) =>
      HomeState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        campaigns: campaigns ?? this.campaigns,
        user: user ?? this.user,
        filteredCampaigns: filteredCampaigns ?? this.filteredCampaigns,
      );
}
