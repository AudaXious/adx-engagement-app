import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/theme/dark_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
@RoutePage()
class SignInOptionsScreen extends StatelessWidget {
  const SignInOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

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
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            child: SecondaryButton(
                              buttonText: "Sign In with Google",
                              icon: "assets/images/google.png",
                              onPressed: () {
                              },
                            )
                        ),
                        const Gap(20),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            child: SecondaryButton(
                              buttonText: "Sign In with Wallet",
                              icon: "assets/images/wallet_connect.png",
                              onPressed: () {
                                context.router.navigate(WalletLoginRoute());
                              },
                            )
                        ),
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
