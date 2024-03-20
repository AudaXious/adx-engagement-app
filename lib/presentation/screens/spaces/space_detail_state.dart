import 'package:audaxious/domain/models/space.dart';

import '../../../domain/enums/view_state.dart';
import '../../../domain/models/space_details.dart';

class SpaceDetailState {
  factory SpaceDetailState.initial() => const SpaceDetailState._(
    viewState: ViewState.idle,
    error: '',
    space: null
  );
  const SpaceDetailState._({
    required this.viewState,
    required this.error,
    required this.space,
  });

  final ViewState viewState;
  final String error;
  final SpaceDetails? space;

  SpaceDetailState update({
    ViewState? viewState,
    String? error,
    SpaceDetails? space

  }) =>
      SpaceDetailState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        space: space ?? this.space,
      );
}

