import 'package:audaxious/core/utils/theme/dark_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes/app_router.dart';
import '../../../core/services/shared_preferences_services.dart';

@RoutePage()
class BottomBarScreen extends HookConsumerWidget {
  const BottomBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = useState<bool?>(null);

    void _checkLoginStatus() async {
      final loginStatus = await SharedPreferencesServices.getIsLoggedIn();
      isLoggedIn.value = loginStatus;
    }

    useEffect(() {
      _checkLoginStatus();
      return () {
      };
    }, const []);


    return AutoTabsRouter(
      routes: [
        HomeRoute(),
        SpacesRoute(),
        const RaffleRoute(),
        const AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return isLoggedIn.value == true
            ? Scaffold(
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
              enableFeedback: false,
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
        )
            : Scaffold(
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
              enableFeedback: false,
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
              ],
            )
        );
      },
    );
  }
}
