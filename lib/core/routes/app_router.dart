import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/campaign.dart';
import '../../domain/models/space.dart';
import '../../presentation/screens/account/account_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/sign_in_options_screen.dart';
import '../../presentation/screens/auth/verify_otp_screen.dart';
import '../../presentation/screens/auth/create_username_screen.dart';
import '../../presentation/screens/auth/web3modal/connect_wallet_screen.dart';
import '../../presentation/screens/campaigns/campaign_details_screen.dart';
import '../../presentation/screens/intro/on_boarding_screen.dart';
import '../../presentation/screens/main/bottom_bar.dart';
import '../../presentation/screens/main/spaces_screen.dart';
import '../../presentation/screens/main/home_screen.dart';
import '../../presentation/screens/raffles/raffle_screen.dart';
import '../../presentation/screens/spaces/create_community_screen.dart';
import '../../presentation/screens/spaces/space_detail_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [

    //Onboarding
    AutoRoute(page: OnBoardingRoute.page, initial: true),

    //Auth
    AutoRoute(page: SignInOptionsRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: VerifyOTPRoute.page),
    AutoRoute(page: CreateUsernameRoute.page),
    AutoRoute(page: ConnectWalletRoute.page),

    //Bottom nav
    AutoRoute(
      page: BottomBarRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SpacesRoute.page),
        AutoRoute(page: RaffleRoute.page),
        AutoRoute(page: AccountRoute.page),
      ]
    ),

    //Engage portal
    AutoRoute(page: CampaignDetailsRoute.page),

    //Spaces
    AutoRoute(page: CreateCommunityRoute.page),
    AutoRoute(page: SpaceDetailRoute.page),
  ];
}