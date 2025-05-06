import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc_base_structure/config/router/app_route_name.dart';
import 'package:flutter_bloc_base_structure/config/router/app_router_observer.dart';
import 'package:flutter_bloc_base_structure/main.dart';
import 'package:flutter_bloc_base_structure/screens/no_Internet_screen/view/no_internet_screen.dart';

final appRouter = GoRouter(
  observers: [AppRouterObserver()],
  initialLocation: RouteNames.splashView,
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: RouteNames.splashView,
      name: RouteNames.splashView,
      builder: (context, state) {
        return Container();
      },
    ),
    GoRoute(
      path: RouteNames.noInternetView,
      name: RouteNames.noInternetView,
      builder: (context, state) {
        return NoInternetView();
      },
    ),
  ],
);
