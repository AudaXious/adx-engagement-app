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
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
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
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
