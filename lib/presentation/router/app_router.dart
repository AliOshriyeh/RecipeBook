// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:test/presentation/views/home_screen.dart';
import 'package:test/presentation/views/login_screen.dart';
import 'package:test/presentation/views/signup_screen.dart';
import 'package:test/presentation/views/setting_screen.dart';
import 'package:test/presentation/views/edit_recipe_screen.dart';
import 'package:test/presentation/views/local_recipe_screen.dart';
import 'package:test/presentation/views/online_recipe_screen.dart';
import 'package:test/presentation/views/create_recipe_screen.dart';
import 'package:test/presentation/views/online_ingredient_screen.dart';
import 'package:test/presentation/views/modify_ingredients_screen.dart';

class AppRouter {
  static const ROUTE_HOME = "/";
  static const ROUTE_LOGIN = "/auth_login";
  static const ROUTE_SIGNUP = "/auth_signup";
  static const ROUTE_LOCAL = "/recipe_local";
  static const ROUTE_ORECIPE = "/recipe_online";
  static const ROUTE_SETTINGS = "/settings";
  static const ROUTE_OINGREDIENT = "/ingredient_online";
  static const ROUTE_EDITRECIPE = "/edit_create";
  static const ROUTE_CREATERECIPE = "/recipe_create";
  static const ROUTE_MINGREDIENT = "/ingredient_modify";

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => page);
    final args = settings.arguments;
    switch (settings.name) {
      case ROUTE_HOME:
        const page = HomeScreen();
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_LOGIN:
        const page = LoginScreen();
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      case ROUTE_SIGNUP:
        const page = SignUpScreen();
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_LOCAL:
        const page = LocalRecipeScreen();
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_ORECIPE:
        const page = OnlineRecipeScreen();
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_OINGREDIENT:
        const page = OnlineIngredientScreen();
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_CREATERECIPE:
        const page = CreateRecipeScreen();
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_EDITRECIPE:
        var page = EditRecipeScreen(arguments: args);
        return MaterialPageRoute(builder: (_) => page);
      case ROUTE_MINGREDIENT:
        var page = ModifyIngredientsScreen(arguments: args);
        return MaterialPageRoute(builder: (_) => page);
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
        appBar: AppBar(title: const Text("Error"), centerTitle: true),
        body: const Center(child: Text("Page not Found")),
      );
    });
  }
}
