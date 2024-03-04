import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/feed.dart';
import '../../presentation/screens/auth/LoginScreen.dart';
import '../../presentation/screens/intro/on_boarding_screen.dart';
import '../../presentation/screens/main/bottom_bar.dart';
import '../../presentation/screens/main/community/community_screen.dart';
import '../../presentation/screens/main/community/create_community_screen.dart';
import '../../presentation/screens/main/home_screen.dart';
import '../../presentation/screens/posts/post_details_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [

    //Intro
    AutoRoute(page: OnBoardingRoute.page, initial: true),

    //Onboarding
    AutoRoute(page: LoginRoute.page),

    //Bottom nav
    AutoRoute(
      page: BottomBarRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CommunityRoute.page),
      ]
    ),

    //Engage portal
    AutoRoute(page: PostDetailsRoute.page),

    //Community
    AutoRoute(page: CreateCommunityRoute.page),
  ];
}