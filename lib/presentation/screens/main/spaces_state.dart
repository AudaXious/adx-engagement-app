import 'package:audaxious/domain/models/space.dart';

import '../../../domain/enums/view_state.dart';

class SpacesState {
  factory SpacesState.initial() => const SpacesState._(
    spaceViewState: ViewState.idle,
    joinSpaceViewState: ViewState.idle,
    error: '',
    message: '',
    spaces: null
  );
  const SpacesState._({
    required this.spaceViewState,
    required this.joinSpaceViewState,
    required this.error,
    required this.message,
    required this.spaces,
  });

  final ViewState spaceViewState;
  final ViewState joinSpaceViewState;
  final String error;
  final String message;
  final List<Space>? spaces;

  SpacesState update({
    ViewState? spaceViewState,
    ViewState? joinSpaceViewState,
    String? error,
    String? message,
    List<Space>? spaces

  }) =>
      SpacesState._(
        spaceViewState: spaceViewState ?? this.spaceViewState,
        joinSpaceViewState: joinSpaceViewState ?? this.joinSpaceViewState,
        error: error ?? this.error,
        message: message ?? this.message,
        spaces: spaces ?? this.spaces,
      );
}

