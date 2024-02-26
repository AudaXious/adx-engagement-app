import 'package:audaxious/domain/models/feed.dart';

import '../../../domain/enums/view_state.dart';

class HomeState {
  factory HomeState.initial() => const HomeState._(
    viewState: ViewState.idle,
    error: '',
    feeds: null
  );
  const HomeState._({
    required this.viewState,
    required this.error,
    required this.feeds,
  });

  final ViewState viewState;
  final String error;
  final List<Feed>? feeds;

  HomeState update({
    ViewState? viewState,
    String? error,
    List<Feed>? feeds

  }) =>
      HomeState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        feeds: feeds ?? this.feeds,
      );
}

