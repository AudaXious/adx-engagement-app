import 'package:audaxious/domain/models/user.dart';
import '../../../../domain/enums/view_state.dart';

class WalletLoginState {
  factory WalletLoginState.initial() => const WalletLoginState._(
    viewState: ViewState.idle,
    error: '',
    user: null,
  );
  const WalletLoginState._({
    required this.viewState,
    required this.error,
    required this.user,
  });

  final ViewState viewState;
  final String error;
  final User? user;

  WalletLoginState update({
    ViewState? viewState,
    String? error,
    User? user

  }) =>
      WalletLoginState._(
        viewState: viewState ?? this.viewState,
        error: error ?? this.error,
        user: user ?? this.user,
      );
}

