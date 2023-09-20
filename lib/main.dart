// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:test/utils/appObserver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/presentation/router/app_router.dart';

import 'package:test/logic/bloc/1Recipe/recipe_bloc.dart';
import 'package:test/logic/bloc/2OnlineRecipe/online_recipe_bloc.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "The Recipe Book",
        initialRoute: '/recipe_local',
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
