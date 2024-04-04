import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/app_router.dart';

@RoutePage()
class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomeRoute(),
        SpacesRoute(),
        const RaffleRoute(),
        const AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (value) {
                tabsRouter.setActiveIndex(value);
              },
              type: BottomNavigationBarType.fixed,
              elevation: 5,
              selectedItemColor: secondaryColor,
              unselectedItemColor: inActiveBottomBarColor,
              selectedFontSize: 13,
              unselectedFontSize: 13,
              iconSize: 20,
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/home.png", width: 21, height: 21),
                    activeIcon: Image.asset("assets/images/home.png", width: 21, height: 21, color: secondaryColor),
                    label: "Campaigns"
                ),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/spaces.png", width: 23, height: 23),
                    activeIcon: Image.asset("assets/images/spaces.png", width: 23, height: 23, color: secondaryColor),
                    label: "Spaces"
                ),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/raffles.png", width: 24, height: 24),
                    activeIcon: Image.asset("assets/images/raffles.png", width: 24, height: 24, color: secondaryColor),
                    label: "Raffles"
                ),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/account.png", width: 20, height: 19),
                    activeIcon: Image.asset("assets/images/account.png", width: 20, height: 19, color: secondaryColor),
                    label: "Account"
                ),

              ],
            )
        );
      },
    );
  }
}
