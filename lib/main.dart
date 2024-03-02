// ignore_for_file: avoid_renaming_method_parameters,

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/logic/bloc/7Connectivity/connectivity_bloc.dart';
import 'package:test/utils/resources/localizator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:test/utils/appObserver.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/data/models/Ingredient_model.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:test/presentation/themes/dark_theme.dart';
import 'package:test/presentation/themes/light_theme.dart';
import 'package:test/presentation/views/spash_screen.dart';
import 'package:test/data/data_providers/remote/supabase_API.dart';

import 'logic/bloc/1Recipe/recipe_bloc.dart';
import 'logic/bloc/6Authentication/authentication_bloc.dart';
import 'logic/bloc/2OnlineCookBook/online_cookbook_bloc.dart';
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
        BlocProvider(create: (_) => ConnectivityBloc()..add(ConnectivityInitialEvent())),
        BlocProvider(create: (_) {
          AuthenticationBloc().add(const LogoutAuthEvent());
          return AuthenticationBloc()..add(const InitAuthEvent());
        }),
        BlocProvider(create: (_) => OnlineCookBookBloc()..add(ResetOnlineCookBookEvent(Recipe.nullRecipe, Ingredient.nullIngredient))),
        BlocProvider(create: (_) => RecipeBloc()..add(LoadRecipeEvent(Recipe.nullRecipe))),
        BlocProvider(create: (_) => OnlineShowcaseCubit()..initialSetup()),
        BlocProvider(create: (_) => ModifyRecipeImageCubit()..initialSetup()),
        BlocProvider(create: (_) => ModifyIngredientCubit()..initialSetup()),
      ],
      child: MaterialApp(
        supportedLocales: LocalizationManager.allLang,
        locale: const Locale('fa'),
        title: "The Recipe Book",
        theme: lightTheme,
        themeMode: ThemeMode.light,
        darkTheme: darkTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        // initialRoute: AppRouter.ROUTE_LOGIN,
        onGenerateRoute: _appRouter.onGenerateRoute,
        onGenerateInitialRoutes: (route) => [MaterialPageRoute(builder: (_) => const SpashScreen())],
      ),
    );
  }
}

//FIXME - Log out user from supabase when app is closed or paused
// @override
// void didChangeAppLifecycleState(AppLifecycleState state) async {
//   final SupaRecipeRepository repo = SupaRecipeRepository();
//   switch (state) {
//     case AppLifecycleState.resumed:
//       //Execute the code here when user come back the app.
//       //In my case, I needed to show if user active or not,
//       debugPrint(printSignifier +"Exited the app");
//       // FirebaseMethods().updateLiveStatus(_authInstance.currentUser.uid, true);
//       break;
//     case AppLifecycleState.paused:
//       //Execute the code the when user leave the app
//       debugPrint(printSignifier +"LOGGED OUT");
//       var backfeed = await repo.logout();
//       debugPrint(backfeed);
//       // FirebaseMethods().updateLiveStatus(_authInstance.currentUser.uid, false);
//       break;
//     default:
//       break;
//   }
// }
