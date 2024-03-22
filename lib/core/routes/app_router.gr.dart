// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BottomBarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BottomBarScreen(),
      );
    },
    CampaignDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CampaignDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CampaignDetailsScreen(
          key: args.key,
          post: args.post,
          postIndex: args.postIndex,
        ),
      );
    },
    CreateCommunityRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateCommunityScreen(),
      );
    },
    CreateUsernameRoute.name: (routeData) {
      final args = routeData.argsAs<CreateUsernameRouteArgs>(
          orElse: () => const CreateUsernameRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateUsernameScreen(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeScreen(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(key: args.key),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnBoardingScreen(),
      );
    },
    SignInOptionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInOptionsScreen(),
      );
    },
    SpaceDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SpaceDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SpaceDetailScreen(
          key: args.key,
          spaceId: args.spaceId,
        ),
      );
    },
    SpacesRoute.name: (routeData) {
      final args = routeData.argsAs<SpacesRouteArgs>(
          orElse: () => const SpacesRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SpacesScreen(key: args.key),
      );
    },
    VerifyOTPRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOTPRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VerifyOTPScreen(
          key: args.key,
          email: args.email,
          usernameExist: args.usernameExist,
          username: args.username,
        ),
      );
    },
  };
}

/// generated route for
/// [BottomBarScreen]
class BottomBarRoute extends PageRouteInfo<void> {
  const BottomBarRoute({List<PageRouteInfo>? children})
      : super(
          BottomBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomBarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CampaignDetailsScreen]
class CampaignDetailsRoute extends PageRouteInfo<CampaignDetailsRouteArgs> {
  CampaignDetailsRoute({
    Key? key,
    required Campaign post,
    required int postIndex,
    List<PageRouteInfo>? children,
  }) : super(
          CampaignDetailsRoute.name,
          args: CampaignDetailsRouteArgs(
            key: key,
            post: post,
            postIndex: postIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'CampaignDetailsRoute';

  static const PageInfo<CampaignDetailsRouteArgs> page =
      PageInfo<CampaignDetailsRouteArgs>(name);
}

class CampaignDetailsRouteArgs {
  const CampaignDetailsRouteArgs({
    this.key,
    required this.post,
    required this.postIndex,
  });

  final Key? key;

  final Campaign post;

  final int postIndex;

  @override
  String toString() {
    return 'CampaignDetailsRouteArgs{key: $key, post: $post, postIndex: $postIndex}';
  }
}

/// generated route for
/// [CreateCommunityScreen]
class CreateCommunityRoute extends PageRouteInfo<void> {
  const CreateCommunityRoute({List<PageRouteInfo>? children})
      : super(
          CreateCommunityRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateCommunityRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateUsernameScreen]
class CreateUsernameRoute extends PageRouteInfo<CreateUsernameRouteArgs> {
  CreateUsernameRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CreateUsernameRoute.name,
          args: CreateUsernameRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CreateUsernameRoute';

  static const PageInfo<CreateUsernameRouteArgs> page =
      PageInfo<CreateUsernameRouteArgs>(name);
}

class CreateUsernameRouteArgs {
  const CreateUsernameRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CreateUsernameRouteArgs{key: $key}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [OnBoardingScreen]
class OnBoardingRoute extends PageRouteInfo<void> {
  const OnBoardingRoute({List<PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInOptionsScreen]
class SignInOptionsRoute extends PageRouteInfo<void> {
  const SignInOptionsRoute({List<PageRouteInfo>? children})
      : super(
          SignInOptionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInOptionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SpaceDetailScreen]
class SpaceDetailRoute extends PageRouteInfo<SpaceDetailRouteArgs> {
  SpaceDetailRoute({
    Key? key,
    required String spaceId,
    List<PageRouteInfo>? children,
  }) : super(
          SpaceDetailRoute.name,
          args: SpaceDetailRouteArgs(
            key: key,
            spaceId: spaceId,
          ),
          initialChildren: children,
        );

  static const String name = 'SpaceDetailRoute';

  static const PageInfo<SpaceDetailRouteArgs> page =
      PageInfo<SpaceDetailRouteArgs>(name);
}

class SpaceDetailRouteArgs {
  const SpaceDetailRouteArgs({
    this.key,
    required this.spaceId,
  });

  final Key? key;

  final String spaceId;

  @override
  String toString() {
    return 'SpaceDetailRouteArgs{key: $key, spaceId: $spaceId}';
  }
}

/// generated route for
/// [SpacesScreen]
class SpacesRoute extends PageRouteInfo<SpacesRouteArgs> {
  SpacesRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SpacesRoute.name,
          args: SpacesRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SpacesRoute';

  static const PageInfo<SpacesRouteArgs> page = PageInfo<SpacesRouteArgs>(name);
}

class SpacesRouteArgs {
  const SpacesRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SpacesRouteArgs{key: $key}';
  }
}

/// generated route for
/// [VerifyOTPScreen]
class VerifyOTPRoute extends PageRouteInfo<VerifyOTPRouteArgs> {
  VerifyOTPRoute({
    Key? key,
    required String email,
    required bool usernameExist,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          VerifyOTPRoute.name,
          args: VerifyOTPRouteArgs(
            key: key,
            email: email,
            usernameExist: usernameExist,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyOTPRoute';

  static const PageInfo<VerifyOTPRouteArgs> page =
      PageInfo<VerifyOTPRouteArgs>(name);
}

class VerifyOTPRouteArgs {
  const VerifyOTPRouteArgs({
    this.key,
    required this.email,
    required this.usernameExist,
    required this.username,
  });

  final Key? key;

  final String email;

  final bool usernameExist;

  final String username;

  @override
  String toString() {
    return 'VerifyOTPRouteArgs{key: $key, email: $email, usernameExist: $usernameExist, username: $username}';
  }
}
