// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:test/utils/appObserver.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:test/presentation/themes/dark_theme.dart';
import 'package:test/presentation/themes/light_theme.dart';

import 'package:test/utils/resources/localizator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/data/models/recipe_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/data/data_providers/remote/supabase_API.dart';

import 'logic/bloc/1Recipe/recipe_bloc.dart';
import 'logic/bloc/2OnlineRecipe/online_recipe_bloc.dart';
import 'logic/cubit/3ModifyIngredient/modify_ingredient_cubit.dart';
import 'logic/cubit/4OnlineShowcase/online_showcase_cubit.dart';
import 'logic/cubit/5ModifyRecipeImage/modify_ingredient_image_cubit.dart';

void main() async {
  Bloc.observer = MyGlobalObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: SupabaseAPI.SUPABASE_URL, anonKey: SupabaseAPI.SUPABASE_ANON_KEY);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //NOTE - The Order is Important. Up to Down is like Parent to Child
        BlocProvider(create: (_) => OnlineShowcaseCubit()..initialSetup()),
        BlocProvider(create: (_) => OnlineRecipeBloc()..add(InitOnlineRecipeEvent(Recipe.nullRecipe))),
        BlocProvider(create: (_) => RecipeBloc()..add(LoadRecipeEvent(Recipe.nullRecipe))),
        BlocProvider(create: (_) => ModifyRecipeImageCubit()..initialSetup()),
        BlocProvider(create: (_) => ModifyIngredientCubit()..initialSetup()),
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
