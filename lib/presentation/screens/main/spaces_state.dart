import 'package:audaxious/domain/models/space.dart';

import '../../../domain/enums/view_state.dart';

class SpacesState {
  factory SpacesState.initial() => const SpacesState._(
    spaceViewState: ViewState.idle,
    joinSpaceViewState: ViewState.idle,
    error: '',
    message: '',
    spaces: null,
    filteredSpaces: null,
  );
  const SpacesState._({
    required this.spaceViewState,
    required this.joinSpaceViewState,
    required this.error,
    required this.message,
    required this.spaces,
    required this.filteredSpaces,
  });

  final ViewState spaceViewState;
  final ViewState joinSpaceViewState;
  final String error;
  final String message;
  final List<Space>? spaces;
  final List<Space>? filteredSpaces;

  SpacesState update({
    ViewState? spaceViewState,
    ViewState? joinSpaceViewState,
    String? error,
    String? message,
    List<Space>? spaces,
    List<Space>? filteredSpaces

  }) =>
      SpacesState._(
        spaceViewState: spaceViewState ?? this.spaceViewState,
        joinSpaceViewState: joinSpaceViewState ?? this.joinSpaceViewState,
        error: error ?? this.error,
        message: message ?? this.message,
        spaces: spaces ?? this.spaces,
        filteredSpaces: filteredSpaces ?? this.filteredSpaces,
      );
}

