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
              unselectedItemColor: Colors.grey,
              selectedFontSize: 13,
              unselectedFontSize: 13,
              iconSize: 20,
              items: const [

                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    activeIcon: Icon(Icons.home_filled),
                    label: "Campaigns"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.groups),
                    activeIcon: Icon(Icons.groups),
                    label: "Spaces"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shield_moon_outlined),
                    activeIcon: Icon(Icons.shield_moon_outlined),
                    label: "Raffles"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    activeIcon: Icon(Icons.person),
                    label: "Account"
                ),


                // BottomNavigationBarItem(
                //     icon: Image.asset(
                //       "assets/images/user_group.png",
                //       width: 24,
                //       height: 24,
                //       color: Colors.white,
                //     ),
                //     activeIcon: Image.asset(
                //       "assets/images/user_group.png",
                //       width: 24,
                //       height: 24,
                //       color: secondaryColor,
                //     ),
                //     label: "Spaces"
                // ),
                // BottomNavigationBarItem(
                //     icon: Image.asset(
                //       "assets/images/account_unselected.png",
                //       width: 24,
                //       height: 24,
                //       color: Colors.white,
                //     ),
                //     activeIcon: Image.asset(
                //       "assets/images/account_unselected.png",
                //       width: 24,
                //       height: 24,
                //       color: secondaryColor,
                //     ),
                //     label: "Account"
                // ),

              ],
            )
        );
      },
    );
  }
}
