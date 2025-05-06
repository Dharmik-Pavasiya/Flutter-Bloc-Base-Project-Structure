import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_structure/core/app_extension.dart';

class AppRouterObserver extends NavigatorObserver {
  void _logNavigation(
    String action,
    Route<dynamic>? route,
    Route<dynamic>? previousRoute,
  ) {
    String emoji =
        {"PUSH": "🚀", "POP": "🔙", "REMOVE": "❌", "REPLACE": "🔄"}[action] ??
        "🔵";

    String arrowFormat =
        {
          "PUSH":
              "${previousRoute?.settings.name ?? "None"} ==> ${route?.settings.name ?? "Unknown"}",
          "POP":
              "${previousRoute?.settings.name ?? "Unknown"} <== ${route?.settings.name ?? "None"}",
          "REMOVE":
              "${previousRoute?.settings.name ?? "None"} ✖ ${route?.settings.name ?? "Unknown"}",
          "REPLACE":
              "${previousRoute?.settings.name ?? "None"} 🔄 ${route?.settings.name ?? "Unknown"}",
        }[action] ??
        route?.settings.name ??
        "Unknown";

    "$emoji $action | $arrowFormat".printSuccess;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logNavigation("PUSH", route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logNavigation("POP", route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logNavigation("REMOVE", route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logNavigation("REPLACE", newRoute, oldRoute);
  }
}
