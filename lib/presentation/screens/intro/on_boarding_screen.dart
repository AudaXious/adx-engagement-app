import 'package:audaxious/core/routes/app_router.dart';
import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/app_layout.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 50),
            child: Column(
              children: [
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
                const Gap(50),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                    buttonText: "Login",
                    onPressed: () {
                      context.router.replaceAll([const LoginRoute()]);
                    },
                  )
                  ,
                ),
                const Gap(20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: SecondaryButton(
                    buttonText: "Explore Audaxious",
                    onPressed: () {
                      context.router.replaceAll([const BottomBarRoute()]);
                    },
                  )
                  ,
                ),
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
  final String image, title, description;
  OnBoard({required this.image, required this.title, required this.description});
}

final List<OnBoard> onBoardingData = [
  OnBoard(
      image: "assets/images/x.png",
      title: "Gateway To Web3 Tools & Features",
      description: "Connecting millions of users to web3 applications via social networks "
  ),
  OnBoard(
      image: "assets/images/x.png",
      title: "Gateway To Web3 Tools & Features",
      description: "Connecting millions of users to web3 applications via social networks "
  ),
  OnBoard(
      image: "assets/images/x.png",
      title: "Gateway To Web3 Tools & Features",
      description: "Connecting millions of users to web3 applications via social networks "
  )
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            image,
            width: size.width,
            height: 350,
          ),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}