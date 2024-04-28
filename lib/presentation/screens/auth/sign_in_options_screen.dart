import 'package:audaxious/domain/enums/view_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../../domain/enums/button_state.dart';
import '../../viewmodels/auth/wallet_login_viewmodel.dart';
import '../../widgets/alerts/custom_toast.dart';
import '../../widgets/buttons/connect_wallet_button.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

@RoutePage()
class SignInOptionsScreen extends HookConsumerWidget{
  SignInOptionsScreen({super.key});

  late W3MService _w3mService;

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

    }

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = AppLayout.getSize(context);
    final notifier = ref.read(WalletLoginViewModel.notifier);

    useEffect(() {
      initializeW3MService();
      return () {
      };
    }, const []);

    // Custom hook to listen to app lifecycle state changes
    useEffect(() {
      final WidgetsBindingObserver observer = _AppLifecycleObserver(this, ref, context);
      WidgetsBinding.instance.addObserver(observer);
      return () {
        WidgetsBinding.instance.removeObserver(observer);
      };
    }, []);

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
                              child: ConnectWalletButton(
                                  buttonText: "Sign In with Wallet",
                                  icon: "assets/images/wallet_connect.png",
                                  onPressed: () async {
                                    _w3mService.openModal(context);
                                  },

                              )
                          ),
                          const Gap(30),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextButton(
                              onPressed: () {
                                _launchURL('https://audaxious.com');
                              },
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

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  final SignInOptionsScreen signInOptionsScreen;
  WidgetRef ref;
  BuildContext context;

  _AppLifecycleObserver(this.signInOptionsScreen, this.ref, this.context);

  late W3MService _w3mService;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      initializeW3MService();
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
      print("Web 3 status ${_w3mService.status}");
      print("Web 3 address ${_w3mService.session?.address}");
      loginUser();
    }

  }

  void loginUser() async {
    print("Login started");
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

      // CustomToast.show(
      //   context: context,
      //   title: "Error",
      //   description: "No wallet Id found",
      //   type: ToastificationType.error,
      // );
    }

  }
}