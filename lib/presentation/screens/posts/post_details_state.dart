import 'package:audaxious/domain/models/feed.dart';

import '../../../domain/enums/view_state.dart';

class PostDetailsState {
  factory PostDetailsState.initial() => const PostDetailsState._(
    viewState: ViewState.idle,
    error: '',
    feeds: null
  );
  const PostDetailsState._({
    required this.viewState,
    required this.error,
    required this.feeds,
  });

  final ViewState viewState;
  final String error;
  final List<Feed>? feeds;

  PostDetailsState update({
    ViewState? viewState,
    String? error,
    List<Feed>? feeds

  }) =>
      PostDetailsState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        feeds: feeds ?? this.feeds,
      );
}

