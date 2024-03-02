// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:test/utils/constants/globals.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/data/models/category_model.dart';
import 'package:test/data/repositories/recipe_repo.dart';

part 'online_showcase_state.dart';

class OnlineShowcaseCubit extends Cubit<OnlineShowcaseState> {
  final RecipeRepository repo = RecipeRepository();

  OnlineShowcaseCubit() : super(OnlineShowcaseInitial([], []));

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
      debugPrint(error.message);
    } catch (e) {
      debugPrint(printSignifier + "++ ERROR: $e ++"); //TODO - Snackbar
      rethrow;
    }
  }

  Future fetchCategories() async {
    try {
      final categories = await repo.getAllCategories();
      return categories;
    } on ClientException catch (error) {
      debugPrint(error.message);
    } catch (e) {
      debugPrint(printSignifier + "++ ERROR: $e ++"); //TODO - Snackbar
      rethrow;
    }
  }
}
