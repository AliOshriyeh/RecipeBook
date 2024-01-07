// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test/data/models/Ingredient_model.dart';
import 'package:test/data/models/recipe_model.dart';
// ignore: unused_import
import 'package:test/data/repositories/recipe_repo.dart';
import 'package:test/data/repositories/supabase_repo.dart';

part 'online_cookbook_event.dart';
part 'online_cookbook_state.dart';

class OnlineCookBookBloc extends Bloc<OnlineCookBookEvent, OnlineCookBookState> {
  OnlineCookBookBloc() : super(const OnlineCookBookIdle([], [])) {
    // final RecipeRepository repo = RecipeRepository(); //NOTE -  As ready-made recipes
    final SupaRecipeRepository repo = SupaRecipeRepository();

    on<ResetOnlineCookBookEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const OnlineCookBookIdle([], []));
    });

    on<LoadOnlineRecipeEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      try {
        final recipes = await repo.getAllRecipes();
        emit(OnlineCookBookLoaded(recipes, const []));
      } catch (e) {
        debugPrint("++ ERROR: $e ++"); //TODO - Snackbar
        rethrow;
      }
    });

    on<LoadOnlineIngredientEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      try {
        final ingredients = await repo.getAllIngredients();
        emit(OnlineCookBookLoaded(const [], ingredients));
      } catch (e) {
        debugPrint("++ ERROR: $e ++"); //TODO - Snackbar
        rethrow;
      }
    });

    on<AddOnlineCookBookEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      try {
        await repo.addNewRecipe(event.recipe);
        emit(const OnlineCookBookLoaded([], []));
      } catch (e) {
        debugPrint("++ ERROR: $e ++"); //TODO - Snackbar
      }
    });

    // on<StreamOnlineCookBookEvent>((event, emit) async {
    //   await Future<void>.delayed(const Duration(seconds: 1));
    //   await emit.forEach(
    //     repo.getRecipeStream(),
    //     onData: (data) {
    //       debugPrint("DATA: ${data.runtimeType}");
    //       List<Recipe> foodList = [];
    //       for (var currentFood in data) {
    //         Recipe food = Recipe.fromSupaJSON(currentFood);
    //         foodList.add(food);
    //       }

    //       return OnlineCookBookLoaded(foodList);
    //     },
    //     onError: (error, stackTrace) {
    //       debugPrint("++ ERROR: $error ++"); //TODO - Snackbar
    //       return const OnlineCookBookLoading([]);
    //     },
    //   );
    // });
  }
}
