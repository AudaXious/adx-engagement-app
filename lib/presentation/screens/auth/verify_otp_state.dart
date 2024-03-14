import 'package:audaxious/domain/models/user.dart';

import '../../../domain/enums/view_state.dart';

class VerifyOTPState {
  factory VerifyOTPState.initial() => const VerifyOTPState._(
    viewState: ViewState.idle,
    error: '',
    message: '',
    user: null,
  );
  const VerifyOTPState._({
    required this.viewState,
    required this.error,
    required this.message,
    required this.user,
  });

  final ViewState viewState;
  final String error;
  final String message;
  final User? user;

  VerifyOTPState update({
    ViewState? viewState,
    String? error,
    String? message,
    User? user

  }) =>
      VerifyOTPState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        message: message ?? this.message,
        user: user ?? this.user,
      );
}

