import 'package:audaxious/domain/models/user.dart';

import '../../../domain/enums/view_state.dart';

class OTPState {
  factory OTPState.initial() => const OTPState._(
    viewState: ViewState.idle,
    error: '',
    user: null,
    isSuccessful: null
  );
  const OTPState._({
    required this.viewState,
    required this.error,
    required this.user,
    required this.isSuccessful,
  });

  final ViewState viewState;
  final String error;
  final User? user;
  final bool? isSuccessful;

  OTPState update({
    ViewState? viewState,
    String? error,
    User? user,
    bool? isSuccessful,

  }) =>
      OTPState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        user: user ?? this.user,
        isSuccessful: isSuccessful ?? this.isSuccessful,
      );
}

