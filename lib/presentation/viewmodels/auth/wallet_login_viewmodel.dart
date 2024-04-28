
import 'package:audaxious/domain/usecases/auth/wallet_login_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../screens/auth/web3modal/wallet_login_state.dart';
import '../../widgets/alerts/custom_toast.dart';

class WalletLoginViewModel extends StateNotifier<WalletLoginState> {
  WalletLoginUseCase walletLoginUseCase;

  WalletLoginViewModel({
    required this.walletLoginUseCase,
  }) : super (WalletLoginState.initial());

  static final notifier =
  StateNotifierProvider<WalletLoginViewModel, WalletLoginState>((ref) => WalletLoginViewModel(
      walletLoginUseCase: ref.read(walletLoginUseCaseProvider),
  ));


  Future<User?> loginUser(String walletId, BuildContext context) async {
      state = state.update(viewState: ViewState.loading);
      // context.loaderOverlay.show();
      // context.loaderOverlay.visible;
      try {
        final response = await walletLoginUseCase.walletLogin(walletId.trim());
        final success = response['success'];
        final data = response['data'];
        final message = response['message'];

        if (success != null && success == true) {
          if (data != null) {
            final user = User.fromJson(data);
            state = state.update(user: user);
            // context.loaderOverlay.hide();
            return user;
          }

          state = state.update(viewState: ViewState.idle);
          // context.loaderOverlay.hide();
        }

      } catch (e) {
        state = state.update(viewState: ViewState.error);
        state = state.update(error: e.toString());
        // context.loaderOverlay.hide();
        CustomToast.show(
          context: context,
          title: "Error",
          description: e.toString(),
          type: ToastificationType.error,
        );
        print("View model error: ${e.toString()}");
        return null;
      }

      return null;
    }

}


