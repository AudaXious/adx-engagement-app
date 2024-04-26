import 'package:audaxious/domain/enums/view_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../../../../core/routes/app_router.dart';
import '../../../viewmodels/auth/wallet_login_viewmodel.dart';
import '../../../widgets/alerts/custom_toast.dart';
import '../../../widgets/progressBars/circular_progress_bar.dart';

@RoutePage()
class WalletLoginScreen extends HookConsumerWidget {
  WalletLoginScreen({super.key});

  late W3MService _w3mService;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reader = ref.read(WalletLoginViewModel.notifier.notifier);
    final notifier = ref.read(WalletLoginViewModel.notifier);

    void initializeW3MService() async {
      _w3mService = W3MService(
        projectId: '70630571fe8c62c8b5dfffe48ebc8c79',
        metadata: const PairingMetadata(
          name: 'Audaxious',
          description: 'Connect wallet to AudaXious',
          url: 'https://www.audaxious.com/',
          icons: ['https://walletconnect.com/walletconnect-logo.png'],
          redirect: Redirect(
            native: 'audaxious://',
            universal: 'https://www.walletconnect.com',
          ),
        ),
      );

      await _w3mService.init();
      if (_w3mService.status == W3MServiceStatus.initialized) {
        final walletId = _w3mService.session?.address;
        print(walletId);

        if (walletId != null) {
          final user = await reader.loginUser(walletId, context);
          if (user == null) {
            if (!context.mounted) return;
            CustomToast.show(
              context: context,
              title: "Error",
              description: "Failed to login user. Please try again!",
              type: ToastificationType.error,
            );

          }else {
            if (user.username == null) {
              if (!context.mounted) return;
              print("User name does not exists ${user.username}");
              context.router.navigate(CreateUsernameRoute());
            }else {
              if (!context.mounted) return;
              print("User name exists ${user.username}");
              context.router.replaceAll([const BottomBarRoute()]);
            }
          }

        }else {
          // CustomToast.show(
          //   context: context,
          //   title: "Error",
          //   description: "No wallet address found. Please try again!",
          //   type: ToastificationType.error,
          // );
        }

            }
    }

    useEffect(() {
      initializeW3MService();
      return () {
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In with Wallet",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: notifier.viewState.isLoading ? CircularProgressBar()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              W3MConnectWalletButton(service: _w3mService),
              // W3MConnectWalletButton(
              //   service: _w3mService,
              //   state: ConnectButtonState.none,
              // ),
              // const Gap(20),
              // W3MNetworkSelectButton(service: _w3mService),
              // const Gap(20),
              // W3MAccountButton(service: _w3mService),
            ],
          ),
        ),
      ),
    );
  }
}
