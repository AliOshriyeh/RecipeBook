import 'dart:convert';

import 'package:test/data/data_providers/remote/recipe_API.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  final RecipeAPI api = RecipeAPI();

  Future<List<Recipe>> getAllRecipe() async {
    final http.Response? result = await api.getRawRecipeByName("");
    if (result == null) {
      return [Recipe.nullRecipe];
    } else {
      List<Recipe> foodList = [];
      final List<dynamic> foods = json.decode(result.body)["meals"];
      for (var currentFood in foods) {
        Recipe food = Recipe.fromJSON(currentFood);
        foodList.add(food);
      }
      return foodList;
    }
  }

  Future<Recipe> getRecipeByName(String name) async {
    final http.Response? result = await api.getRawRecipeByName(name);
    if (result == null) {
      return Recipe.nullRecipe;
    } else {
      final List<dynamic> foods = json.decode(result.body)["meals"];
      final Recipe recipe = Recipe.fromJSON(foods.first);
      return recipe;
    }
  }
}
