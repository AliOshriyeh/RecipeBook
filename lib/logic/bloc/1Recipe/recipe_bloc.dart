// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/data/data_providers/local/sqflite_prov.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeInitial([])) {
    on<LoadRecipeEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      try {
        var _recipes = await DatabaseProvider.db.getFoods();
        emit(RecipeLoaded(_recipes));
      } catch (e) {
        debugPrint("++ ERROR: $e ++"); //TODO - Snackbar
        rethrow;
      }
      DatabaseProvider.db.close();
    });

    // Upon Adding a New Recipe by User, Add it to RecipesList.
    on<AddRecipeEvent>((event, emit) async {
      if (state is RecipeLoaded) {
        try {
          await DatabaseProvider.db.insert(event.recipe);
          var _recipes = await DatabaseProvider.db.getFoods();
          emit(RecipeLoaded(_recipes));
        } catch (e) {
          debugPrint("++ ERROR: $e ++"); //TODO - Snackbar
          rethrow;
        }

        DatabaseProvider.db.close();
      }
    });

    //Upon Removing an Existing Recipe by User, Remove it from RecipesList.
    on<RemoveRecipeEvent>((event, emit) async {
      if (state is RecipeLoaded) {
        try {
          await DatabaseProvider.db.delete(event.recipe);
          var _recipes = await DatabaseProvider.db.getFoods();
          emit(RecipeLoaded(_recipes));
        } catch (e) {
          debugPrint("++ ERROR: $e ++");
          rethrow;
        }
        DatabaseProvider.db.close();
      }
    });

    //Upon Editing an Existing Recipe by User, Edit it in RecipesList.
    on<EditRecipeEvent>((event, emit) async {
      if (state is RecipeLoaded) {
        try {
          await DatabaseProvider.db.update(event.recipe);
          var _recipes = await DatabaseProvider.db.getFoods();
          emit(RecipeLoaded(_recipes));
        } catch (e) {
          debugPrint("++ ERROR: $e ++");
          rethrow;
        }
        DatabaseProvider.db.close();
      }
    });
  }
}
