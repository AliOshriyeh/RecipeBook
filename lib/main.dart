// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:test/presentation/themes/dark_theme.dart';
import 'package:test/presentation/themes/light_theme.dart';
import 'package:test/utils/appObserver.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test/utils/resources/localizator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/data/models/recipe_model.dart';

import 'logic/bloc/1Recipe/recipe_bloc.dart';
import 'logic/bloc/2OnlineRecipe/online_recipe_bloc.dart';
import 'package:test/logic/cubit/modify_ingredient_cubit.dart';
import 'package:test/presentation/widgets/create_recipe_dialoge.dart';

void main() {
  Bloc.observer = MyGlobalObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RecipeBloc()..add(LoadRecipeEvent(Recipe.nullRecipe))),
        BlocProvider(create: (_) => OnlineRecipeBloc()..add(LoadOnlineRecipeEvent(Recipe.nullRecipe))),
        BlocProvider(create: (_) => ModifyIngredientCubit()..initialSetup(), child: const CreateRecipeDialog()),
      ],
      child: MaterialApp(
        supportedLocales: LocalizationManager.allLang,
        locale: const Locale('en'),
        title: "The Recipe Book",
        theme: lightTheme,
        // themeMode: ThemeMode.dark,
        darkTheme: darkTheme,
        initialRoute: '/',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
