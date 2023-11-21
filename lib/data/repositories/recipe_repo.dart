import 'dart:convert';

import 'package:test/data/data_providers/remote/recipe_API.dart';
import 'package:test/data/models/category_model.dart';
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

  Future<List<Category>> getAllCategories() async {
    final http.Response? result = await api.getRawCategories();
    if (result == null) {
      return [Category.nullcategory];
    } else {
      List<Category> cateList = [];
      final List<dynamic> categories = json.decode(result.body)["categories"];
      for (var currentCate in categories) {
        Category category = Category.fromJSON(currentCate);
        cateList.add(category);
      }
      return cateList;
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
