// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/data/repositories/recipe_repo.dart';

part 'online_recipe_event.dart';
part 'online_recipe_state.dart';

class OnlineRecipeBloc extends Bloc<OnlineRecipeEvent, OnlineRecipeState> {
  OnlineRecipeBloc() : super(const OnlineRecipeInitial([])) {
    final RecipeRepository repo = RecipeRepository();

    on<LoadOnlineRecipeEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      try {
        final recipes = await repo.getAllRecipe();
        emit(OnlineRecipeLoaded(recipes));
      } catch (e) {
        print(e); //TODO - Snackbar
      }
    });
  }
}
