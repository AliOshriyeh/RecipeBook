// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:test/data/models/category_model.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/data/repositories/recipe_repo.dart';

part 'online_showcase_state.dart';

class OnlineShowcaseCubit extends Cubit<OnlineShowcaseState> {
  OnlineShowcaseCubit() : super(OnlineShowcaseInitial([], []));
  final RecipeRepository repo = RecipeRepository();

  void initialSetup() => emit(OnlineShowcaseInitial([], []));

  void displayShowcases() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    var recipeList, categoryList;
    do {
      recipeList = await fetchRecipes();
      categoryList = await fetchCategories();
    } while (recipeList == null || categoryList == null);

    emit(OnlineShowcaseLoaded(categoryList, recipeList));
  }

  Future fetchRecipes() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      final recipes = await repo.getAllRecipe();
      return recipes;
    } on ClientException catch (error) {
      print(error.message);
    } catch (e) {
      print("++ ERROR: $e ++"); //TODO - Snackbar
      rethrow;
    }
  }

  Future fetchCategories() async {
    try {
      final categories = await repo.getAllCategories();
      return categories;
    } on ClientException catch (error) {
      print(error.message);
    } catch (e) {
      print("++ ERROR: $e ++"); //TODO - Snackbar
      rethrow;
    }
  }
}
