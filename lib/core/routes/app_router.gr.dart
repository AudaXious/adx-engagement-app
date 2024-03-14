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
    CommunityRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CommunityScreen(),
      );
    },
    CreateCommunityRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateCommunityScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
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
    OTPRoute.name: (routeData) {
      final args = routeData.argsAs<OTPRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VerifyOTPScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnBoardingScreen(),
      );
    },
    PostDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PostDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PostDetailsScreen(
          key: args.key,
          post: args.post,
          postIndex: args.postIndex,
        ),
      );
    },
    SetUsernameRoute.name: (routeData) {
      final args = routeData.argsAs<SetUsernameRouteArgs>(
          orElse: () => const SetUsernameRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateUsernameScreen(key: args.key),
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
/// [CommunityScreen]
class CommunityRoute extends PageRouteInfo<void> {
  const CommunityRoute({List<PageRouteInfo>? children})
      : super(
          CommunityRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommunityRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [VerifyOTPScreen]
class OTPRoute extends PageRouteInfo<OTPRouteArgs> {
  OTPRoute({
    Key? key,
    required String email,
    List<PageRouteInfo>? children,
  }) : super(
          OTPRoute.name,
          args: OTPRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPRoute';

  static const PageInfo<OTPRouteArgs> page = PageInfo<OTPRouteArgs>(name);
}

class OTPRouteArgs {
  const OTPRouteArgs({
    this.key,
    required this.email,
  });

  final Key? key;

  final String email;

  @override
  String toString() {
    return 'OTPRouteArgs{key: $key, email: $email}';
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
/// [PostDetailsScreen]
class PostDetailsRoute extends PageRouteInfo<PostDetailsRouteArgs> {
  PostDetailsRoute({
    Key? key,
    required Feed post,
    required int postIndex,
    List<PageRouteInfo>? children,
  }) : super(
          PostDetailsRoute.name,
          args: PostDetailsRouteArgs(
            key: key,
            post: post,
            postIndex: postIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'PostDetailsRoute';

  static const PageInfo<PostDetailsRouteArgs> page =
      PageInfo<PostDetailsRouteArgs>(name);
}

class PostDetailsRouteArgs {
  const PostDetailsRouteArgs({
    this.key,
    required this.post,
    required this.postIndex,
  });

  final Key? key;

  final Feed post;

  final int postIndex;

  @override
  String toString() {
    return 'PostDetailsRouteArgs{key: $key, post: $post, postIndex: $postIndex}';
  }
}

/// generated route for
/// [CreateUsernameScreen]
class SetUsernameRoute extends PageRouteInfo<SetUsernameRouteArgs> {
  SetUsernameRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SetUsernameRoute.name,
          args: SetUsernameRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SetUsernameRoute';

  static const PageInfo<SetUsernameRouteArgs> page =
      PageInfo<SetUsernameRouteArgs>(name);
}

class SetUsernameRouteArgs {
  const SetUsernameRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SetUsernameRouteArgs{key: $key}';
  }
}
