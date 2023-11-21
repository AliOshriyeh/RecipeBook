// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test/data/models/recipe_model.dart';
// ignore: unused_import
import 'package:test/data/repositories/recipe_repo.dart';
import 'package:test/data/repositories/supabase_repo.dart';

part 'online_recipe_event.dart';
part 'online_recipe_state.dart';

class OnlineRecipeBloc extends Bloc<OnlineRecipeEvent, OnlineRecipeState> {
  OnlineRecipeBloc() : super(const OnlineRecipeInitial([])) {
    // final RecipeRepository repo = RecipeRepository();
    final SupaRecipeRepository repo = SupaRecipeRepository();

    on<InitOnlineRecipeEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const OnlineRecipeInitial([]));
    });

    on<LoadOnlineRecipeEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      try {
        final recipes = await repo.getAllRecipe();
        emit(OnlineRecipeLoaded(recipes));
      } catch (e) {
        print("++ ERROR: $e ++"); //TODO - Snackbar
        rethrow;
      }
    });

    // on<StreamOnlineRecipeEvent>((event, emit) async {
    //   await Future<void>.delayed(const Duration(seconds: 1));
    //   await emit.forEach(
    //     repo.getRecipeStream(),
    //     onData: (data) {
    //       print("DATA: ${data.runtimeType}");
    //       List<Recipe> foodList = [];
    //       for (var currentFood in data) {
    //         Recipe food = Recipe.fromSupaJSON(currentFood);
    //         foodList.add(food);
    //       }

    //       return OnlineRecipeLoaded(foodList);
    //     },
    //     onError: (error, stackTrace) {
    //       print("++ ERROR: $error ++"); //TODO - Snackbar
    //       return const OnlineRecipeLoading([]);
    //     },
    //   );
    // });

    // on<AddOnlineRecipeEvent>((event, emit) async {
    //   await Future<void>.delayed(const Duration(seconds: 1));
    //   try {
    //     final recipes = await repo.addNewRecipe(event.recipe);
    //     recipes.add(event.recipe);
    //     emit(OnlineRecipeLoaded(recipes));
    //   } catch (e) {
    //     print("++ ERROR: $e ++"); //TODO - Snackbar
    //   }
    // });
  }
}
