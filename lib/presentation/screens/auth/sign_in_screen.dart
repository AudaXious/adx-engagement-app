import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
@RoutePage()

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen> {

  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context,) {
    _pageController = PageController(initialPage: 0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 35, bottom: 20),
            child: Column(
              children: [
                Image.asset("assets/images/audaxious_name_logo.png", width: 100, height: 16),
                const Gap(20),
                Expanded(
                    child: PageView.builder(
                        itemCount: onBoardingData.length,
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _pageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) => OnBoardingContent(
                          title: onBoardingData[index].title,
                        ))
                ),
                const Gap(30),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    child: SecondaryButton(
                      buttonText: "Sign in with WalletConnect",
                      icon: "assets/images/wallet_connect.png",
                      onPressed: () {
                      },
                    )
                ),
                const Gap(50),
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
            ),
          )
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ?  8 : 7,
      width: isActive ? 23 : 7,
      decoration: BoxDecoration(
          color: isActive ? secondaryColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}


class OnBoard{
  final String title;
  OnBoard({required this.title});
}

final List<OnBoard> onBoardingData = [
  OnBoard(
      title: "Sign In",
  ),
];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/on_boarding_bg.png',
          // fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
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
        Container(
          width: double.infinity,
          height: double.infinity,
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
        Container(
          width: double.infinity,
          height: double.infinity,
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const SizedBox(height: 150),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        )
      ],
    );
  }
}