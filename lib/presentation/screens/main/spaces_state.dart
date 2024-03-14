import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/models/space.dart';

import '../../../domain/enums/view_state.dart';

class SpacesState {
  factory SpacesState.initial() => const SpacesState._(
    viewState: ViewState.idle,
    error: '',
    spaces: null
  );
  const SpacesState._({
    required this.viewState,
    required this.error,
    required this.spaces,
  });

  final ViewState viewState;
  final String error;
  final List<Space>? spaces;

  SpacesState update({
    ViewState? viewState,
    String? error,
    List<Space>? spaces

  }) =>
      SpacesState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        spaces: spaces ?? this.spaces,
      );
}

