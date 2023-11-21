// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:test/presentation/views/homescreen.dart';
import 'package:test/presentation/views/setting_screen.dart';
import 'package:test/presentation/views/global_recipe_screen.dart';
import 'package:test/presentation/views/local_recipe_screen.dart';

class AppRouter {
  static const ROUTE_HOME = "/";
  static const ROUTE_LOCAL = "/recipe_local";
  static const ROUTE_ONLINE = "/recipe_online";
  static const ROUTE_SETTINGS = "/settings";

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final arg = routeSettings.arguments;

    switch (settings.name) {
      case ROUTE_HOME:
        const page = HomeScreen();
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_LOCAL:
        const page = LocalRecipeScreen();
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_ONLINE:
        const page = GlobalRecipeScreen();
        return MaterialPageRoute(builder: (_) => page, maintainState: false);
      case ROUTE_SETTINGS:
        const page = SettingScreen();
        return MaterialPageRoute(builder: (_) => page);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ERROR"),
          centerTitle: true,
        ),
        body: const Center(child: Text("Page not Found")),
      );
    });
  }
}
