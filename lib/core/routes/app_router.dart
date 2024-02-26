import 'package:auto_route/auto_route.dart';

import '../../presentation/screens/main/bottom_bar.dart';
import '../../presentation/screens/main/community_screen.dart';
import '../../presentation/screens/main/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: BottomBarRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CommunityRoute.page),
      ]
    )
  ];
}