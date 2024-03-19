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
    SpacesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SpacesScreen(),
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
/// [SpacesScreen]
class SpacesRoute extends PageRouteInfo<void> {
  const SpacesRoute({List<PageRouteInfo>? children})
      : super(
          SpacesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SpacesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
