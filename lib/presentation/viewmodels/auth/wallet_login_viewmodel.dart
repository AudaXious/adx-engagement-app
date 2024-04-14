
import 'package:audaxious/domain/usecases/auth/login_usecase.dart';
import 'package:audaxious/domain/usecases/auth/wallet_login_usecase.dart';
import 'package:audaxious/presentation/screens/auth/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../screens/auth/web3modal/wallet_login_state.dart';

class WalletLoginViewModel extends StateNotifier<WalletLoginState> {
  WalletLoginUseCase walletLoginUseCase;

  WalletLoginViewModel({
    required this.walletLoginUseCase,
  }) : super (WalletLoginState.initial());

  static final notifier =
  StateNotifierProvider<WalletLoginViewModel, WalletLoginState>((ref) => WalletLoginViewModel(
      walletLoginUseCase: ref.read(walletLoginUseCaseProvider),
  ));

  Future<User?> loginUser(String walletId) async {
      state = state.update(viewState: ViewState.loading);
      try {
        final response = await walletLoginUseCase.walletLogin(walletId.trim());
        final success = response['success'];
        final data = response['data'];

        if (success != null && success == true) {
          if (data != null) {
            final user = User.fromJson(data);
            state = state.update(user: user);
            return user;
          }

          state = state.update(viewState: ViewState.idle);
        }

      } catch (e) {
        state = state.update(viewState: ViewState.error);
        state = state.update(error: e.toString());
        print("View model error: ${e.toString()}");
        return null;
      }

      return null;
    }

}


