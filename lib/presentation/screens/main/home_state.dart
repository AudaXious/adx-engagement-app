import 'package:audaxious/domain/models/feed.dart';

import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';

class HomeState {
  factory HomeState.initial() => const HomeState._(
    viewState: ViewState.idle,
    error: '',
    feeds: null,
    user: null,
  );
  const HomeState._({
    required this.viewState,
    required this.error,
    required this.feeds,
    required this.user,
  });

  final ViewState viewState;
  final String error;
  final List<Feed>? feeds;
  final User? user;

  HomeState update({
    ViewState? viewState,
    String? error,
    List<Feed>? feeds,
    User? user

  }) =>
      HomeState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        feeds: feeds ?? this.feeds,
        user: user ?? this.user,
      );
}

