import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/bloc/recipe_bloc.dart';
import 'package:test/presentation/views/homescreen.dart';
import 'package:test/utils/appObserver.dart';

void main() {
  Bloc.observer = MyGlobalObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BlocProvider(create: (context) => RecipeCubit()..loadRecipes([]))
          // BlocProvider(create: (context) => RecipeBloc(context.read<DatabaseCubit>().database!)..add(LoadEventRecipe())),
          // BlocProvider(create: (context) => DatabaseCubit()..initDatabase()),
          BlocProvider(create: (context) => RecipeBloc()..add(LoadRecipeEvent())),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "The Recipe Book",
          home: HomeScreen(),
        ));
  }
}
