import 'package:audaxious/domain/models/campaign.dart';

import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';

class HomeState {
  factory HomeState.initial() => const HomeState._(
    viewState: ViewState.idle,
    error: '',
    campaigns: null,
    user: null,
  );
  const HomeState._({
    required this.viewState,
    required this.error,
    required this.campaigns,
    required this.user,
  });

  final ViewState viewState;
  final String error;
  final List<Campaign>? campaigns;
  final User? user;

  HomeState update({
    ViewState? viewState,
    String? error,
    List<Campaign>? campaigns,
    User? user

  }) =>
      HomeState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        campaigns: campaigns ?? this.campaigns,
        user: user ?? this.user,
      );
}

