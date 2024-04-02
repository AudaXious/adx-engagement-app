import 'package:audaxious/domain/models/user.dart';

import '../../../domain/enums/view_state.dart';

class VerifyTwitterState {
  factory VerifyTwitterState.initial() => const VerifyTwitterState._(
    viewState: ViewState.idle,
    error: '',
    user: null,
  );
  const VerifyTwitterState._({
    required this.viewState,
    required this.error,
    required this.user,
  });

  final ViewState viewState;
  final String error;
  final User? user;

  VerifyTwitterState update({
    ViewState? viewState,
    String? error,
    User? user

  }) =>
      VerifyTwitterState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        user: user ?? this.user,
      );
}

