import 'package:audaxious/domain/models/user.dart';

import '../../../domain/enums/view_state.dart';

class AccountState {
  factory AccountState.initial() => const AccountState._(
    logoutViewState: ViewState.idle,
    profileViewState: ViewState.idle,
    error: '',
    user: null,
    isLoggedIn: null
  );
  const AccountState._({
    required this.logoutViewState,
    required this.profileViewState,
    required this.error,
    required this.user,
    required this.isLoggedIn,
  });

  final ViewState logoutViewState;
  final ViewState profileViewState;
  final String error;
  final User? user;
  final bool? isLoggedIn;

  AccountState update({
    ViewState? logoutViewState,
    ViewState? profileViewState,
    String? error,
    User? user,
    bool? isLoggedIn

  }) =>
      AccountState._(
        logoutViewState: logoutViewState ?? this.logoutViewState,
        profileViewState: profileViewState ?? this.profileViewState,
        error: error ?? this.error,
        user: user ?? this.user,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      );
}

