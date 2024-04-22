
import 'package:audaxious/domain/usecases/auth/wallet_login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
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

  // void initializeW3MService() async {
  //   print("Initialization started");
  //   late W3MService _w3mService;
  //
  //   _w3mService = W3MService(
  //     projectId: '70630571fe8c62c8b5dfffe48ebc8c79',
  //     metadata: const PairingMetadata(
  //       name: 'Audaxious',
  //       description: 'Connect wallet to AudaXious',
  //       url: 'https://www.audaxious.com/',
  //       icons: ['https://walletconnect.com/walletconnect-logo.png'],
  //       redirect: Redirect(
  //         native: 'audaxious://',
  //         universal: 'https://www.walletconnect.com',
  //       ),
  //     ),
  //   );
  //
  //   await _w3mService.init();
  //   if (_w3mService.status == W3MServiceStatus.initialized) {
  //     final walledId = _w3mService.session?.address;
  //     if(walledId != null) {
  //       loginUser(walledId);
  //     }
  //   }
  //
  //   // print("Wallet addressxyz ${_w3mService.session!.address!}");
  // }

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


