import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/app_layout.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:audaxious/presentation/widgets/progressBars/circular_progress_bar.dart';
import 'package:audaxious/presentation/widgets/progressBars/custom_loader.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/services/shared_preferences_services.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
@RoutePage()
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  bool _loginChecked = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _checkLoginStatus();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await SharedPreferencesServices.getIsLoggedIn();
    if (isLoggedIn) {
      context.router.replaceAll([const BottomBarRoute()]);
    }

    setState(() {
      _loginChecked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: _loginChecked
              ? Column(
            children: [
              const Gap(35),
              Image.asset("assets/images/audaxious_name_logo.png", width: 100, height: 16),
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
                        image: onBoardingData[index].image,
                        title: onBoardingData[index].title,
                        description: onBoardingData[index].description,
                      ))
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(onBoardingData.length, (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(isActive: index == _pageIndex),
                  )),
                ],
              ),
              const Gap(30),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                    buttonText: "Sign In",
                    onPressed: () {
                      context.router.navigate(SignInOptionsRoute());
                    },
                  )
              ),
              const Gap(20),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: SecondaryButton(
                    buttonText: "Explore",
                    onPressed: () {
                      context.router.replaceAll([const BottomBarRoute()]);
                    },
                  )
              ),
              const Gap(50),
            ],
          )
              : Center(child: CustomLoader())
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
      height: isActive ?  4 : 3,
      width: isActive ? 23 : 7,
      decoration: BoxDecoration(
          color: isActive ? secondaryColor : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}


class OnBoard{
  final String image, title, description;
  OnBoard({required this.image, required this.title, required this.description});
}

final List<OnBoard> onBoardingData = [
  OnBoard(
      image: "assets/images/on_boarding_bg.png",
      title: "ADX Engage to Earn",
      description: "Start earning, winning  rewards, and airdrops by engaging, creating quality contents, and contributing to web3 communities."
  ),
  OnBoard(
      image: "assets/images/on_boarding_bg.png",
      title: "ADX Engage to Earn",
      description: "An easy to use Engage to Earn App that connects you to thousands of web3 projects where you can earn rewards and airdrops"
  ),
];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/on_boarding_bg2.png',
          width: size.width*0.7,
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
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: greyTextColor),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        )
      ],
    );
  }
}