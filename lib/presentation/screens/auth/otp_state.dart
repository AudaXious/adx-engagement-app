import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/models/user.dart';

import '../../../domain/enums/view_state.dart';

class OTPState {
  factory OTPState.initial() => const OTPState._(
    viewState: ViewState.idle,
    error: '',
    user: null
  );
  const OTPState._({
    required this.viewState,
    required this.error,
    required this.user,
  });

  final ViewState viewState;
  final String error;
  final User? user;

  OTPState update({
    ViewState? viewState,
    String? error,
    User? user

  }) =>
      OTPState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        user: user ?? this.user,
      );
}

