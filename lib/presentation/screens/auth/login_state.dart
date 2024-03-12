import 'package:audaxious/domain/models/user.dart';

import '../../../domain/enums/view_state.dart';

class LoginState {
  factory LoginState.initial() => const LoginState._(
    viewState: ViewState.idle,
    error: '',
    user: null
  );
  const LoginState._({
    required this.viewState,
    required this.error,
    required this.user,
  });

  final ViewState viewState;
  final String error;
  final User? user;

  LoginState update({
    ViewState? viewState,
    String? error,
    User? user

  }) =>
      LoginState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        user: user ?? this.user,
      );
}

