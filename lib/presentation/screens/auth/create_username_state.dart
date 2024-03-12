import 'package:audaxious/domain/models/user.dart';

import '../../../domain/enums/view_state.dart';

class CreateUsernameState {
  factory CreateUsernameState.initial() => const CreateUsernameState._(
    viewState: ViewState.idle,
    error: '',
    user: null
  );
  const CreateUsernameState._({
    required this.viewState,
    required this.error,
    required this.user,
  });

  final ViewState viewState;
  final String error;
  final User? user;

  CreateUsernameState update({
    ViewState? viewState,
    String? error,
    User? user

  }) =>
      CreateUsernameState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        user: user ?? this.user,
      );
}

