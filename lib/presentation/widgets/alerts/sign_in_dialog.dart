
import 'package:audaxious/domain/enums/view_state.dart';
import 'package:audaxious/presentation/viewmodels/auth/login_viewmodel.dart';
import 'package:audaxious/presentation/widgets/buttons/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../core/utils/view_utils.dart';
import '../../../core/web3/constants.dart';
import '../../../domain/enums/button_state.dart';
import '../../viewmodels/auth/wallet_login_viewmodel.dart';
import '../buttons/connect_wallet_button.dart';
import '../buttons/secondary_button.dart';
import 'custom_toast.dart';

class SignInDialog extends HookConsumerWidget {
  SignInDialog({super.key});

  late W3MService _w3mService;

  void initializeW3MService() async {
    _w3mService = W3MService(
      projectId: projectId,
      metadata: const PairingMetadata(
        name: 'AudaXious',
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
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(LoginViewModel.notifier);
    final reader = ref.read(LoginViewModel.notifier.notifier);
    final isFormValidated = useState(false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                border: Border.all(width: 0.6, color: cardBorderColor),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: spacesCardColor
            ),
            // height: size.height * 0.5,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close)
                      )
                    ],
                  ),
                  Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Gap(30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: primaryTextFormFieldDecoration(labelText: 'Enter email address'),
                      validator: emailValidator,
                      onChanged: (_) {
                        isFormValidated.value = formKey.currentState?.validate() ?? false;
                      },
                    ),
                  ),
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 45,
                    child: PrimaryButton(
                      buttonText: "Sign In with Email",
                      onPressed: () async {
                        bool isLoginSuccessful = await reader.loginUser(_emailController.text, context);
                        if (isLoginSuccessful) {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                          context.router.navigate(VerifyOTPRoute(
                            email: _emailController.text,
                          ));
                        }
                      },
                      buttonState: notifier.viewState.isLoading
                          ? ButtonState.loading
                          : isFormValidated.value
                          ? ButtonState.active
                          : ButtonState.disabled,
                    ),
                  ),
                  const Gap(20),
                  const Text("Or"),
                  const Gap(20),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 45,
                      child: SecondaryButton(
                        buttonText: "Sign in with Google",
                        icon: "assets/images/google.png",
                        onPressed: () {
                        },
                      )
                  ),
                  const Gap(20),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 45,
                      child: ConnectWalletButton(
                        buttonText: "Sign In with Wallet",
                        icon: "assets/images/wallet_connect.png",
                        onPressed: () async {
                          _w3mService.openModal(context);
                        },

                      )
                  ),
                  const Gap(40),

                ],
              ),
            ),
        ),
        ),
      );
  }

}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  final SignInDialog signInDialog;
  WidgetRef ref;
  BuildContext context;

  _AppLifecycleObserver(this.signInDialog, this.ref, this.context);

  late W3MService _w3mService;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      initializeW3MService();
    }
  }

  void initializeW3MService() async {
    _w3mService = W3MService(
      projectId: projectId,
      metadata: const PairingMetadata(
        name: 'AudaXious',
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
      loginUser();
    }

  }

  void loginUser() async {
    final walletId = _w3mService.session?.address;

    if (walletId != null) {
      context.loaderOverlay.show();
      context.loaderOverlay.visible;
      final user = await ref.read(WalletLoginViewModel.notifier.notifier).loginUser(walletId, context);
      if (user == null) {
        if (!context.mounted) return;
        context.loaderOverlay.hide();
        CustomToast.show(
          context: context,
          title: "Error",
          description: "Failed to login user. Please try again!",
          type: ToastificationType.error,
        );

      }else {
        context.loaderOverlay.hide();
        if (user.username == null) {
          if (!context.mounted) return;
          context.router.navigate(CreateUsernameRoute());
        }else {
          if (!context.mounted) return;
          context.router.replaceAll([const BottomBarRoute()]);
        }
      }

    }else {
      context.loaderOverlay.hide();
    }

  }
}
