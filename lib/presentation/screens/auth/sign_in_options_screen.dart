import 'package:audaxious/domain/enums/view_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';
import '../../viewmodels/auth/wallet_login_viewmodel.dart';
import '../../widgets/alerts/custom_toast.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
@RoutePage()
class SignInOptionsScreen extends HookConsumerWidget {
  SignInOptionsScreen({super.key});

  late W3MService _w3mService;

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     print("hello boy");
  //     // initializeW3MService();
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = AppLayout.getSize(context);
    final reader = ref.read(WalletLoginViewModel.notifier.notifier);
    final notifier = ref.read(WalletLoginViewModel.notifier);

    void loginUser() async {
      print("Login started");

      if (_w3mService != null) {
        final walletId = _w3mService.session?.address;
        print(walletId);

        if (walletId != null) {
          final user = await reader.loginUser(walletId);
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
              // context.router.navigate(CreateUsernameRoute());
            }else {
              if (!context.mounted) return;
              print("User name exists ${user.username}");
              // context.router.replaceAll([const BottomBarRoute()]);
            }
          }

        }else {
        }

      }
    }

    void initializeW3MService() async {
      print("Initialization started");

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
        loginUser();
      }

      // print("Wallet addressxyz ${_w3mService.session!.address!}");
    }

    useEffect(() {
      initializeW3MService();
      return () {
      };
    }, const []);

    // Custom hook to listen to app lifecycle state changes
    // useEffect(() {
    //   final WidgetsBindingObserver observer = _AppLifecycleObserver(ref);
    //   WidgetsBinding.instance!.addObserver(observer);
    //   return () {
    //     WidgetsBinding.instance!.removeObserver(observer);
    //   };
    // }, []);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/audaxious_name_logo.png", width: 100, height: 16),
              ],
            ),
            const Gap(30),
            SizedBox(
              height: 700,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      'assets/images/on_boarding_bg2.png',
                      width: size.width*0.7,
                      height: 500,
                    ),
                  ),

                  Positioned(
                    top: 0,
                    child: Container(
                      width: size.width*0.7,
                      height: 500,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: size.width*0.7,
                      height: 500,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: size.width*0.7,
                      height: 500,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 330,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          "Sign In",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const Gap(20),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: PrimaryButton(
                              buttonText: "Sign In with Email",
                              onPressed: () {
                                context.router.navigate(LoginRoute());
                              },
                            )
                        ),
                        const Gap(20),
                        const Text("Or"),
                        const Gap(20),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: SecondaryButton(
                              buttonText: "Sign In with Google",
                              icon: "assets/images/google.png",
                              onPressed: () {
                              },
                            )
                        ),
                        const Gap(20),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: SecondaryButton(
                              buttonText: "Sign In with Wallet",
                              icon: "assets/images/wallet_connect.png",
                              onPressed: () async {
                                // context.router.navigate(WalletLoginRoute());
                                // initializeW3MService();
                                _w3mService.openModal(context);
                              },
                              buttonState: notifier.viewState.isLoading
                                  ? ButtonState.loading
                                  : ButtonState.active
                            )
                        ),
                        // W3MConnectWalletButton(
                        //   service: _w3mService,
                        //   state: ConnectButtonState.idle,
                        //   size: BaseButtonSize.regular,
                        // ),
                        const Gap(30),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextButton(
                            onPressed: () {},
                            child: RichText(
                              text: TextSpan(
                                text: 'By continuing, you agree our ',
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: greyTextColor, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            ,
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
