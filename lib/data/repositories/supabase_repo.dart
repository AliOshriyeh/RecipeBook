import 'package:flutter/material.dart';
import 'package:test/data/data_providers/remote/supabase_API.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/data/models/Ingredient_model.dart';
import 'package:test/data/models/recipe_model.dart';

class SupaRecipeRepository {
  final SupabaseAPI api = SupabaseAPI();

  Future<List<Recipe>> getAllRecipes() async {
    final List<dynamic>? result = await api.getAllRawRecipe();
    if (result == null) {
      return [Recipe.nullRecipe];
    } else {
      List<Recipe> foodList = [];
      for (var currentFood in result) {
        Recipe food = Recipe.fromSupaJSON(currentFood);
        foodList.add(food);
      }
      return foodList;
    }
  }

  Future<List<Ingredient>> getAllIngredients() async {
    final List<dynamic>? result = await api.getAllRawIngredient();
    if (result == null) {
      return [Ingredient.nullIngredient];
    } else {
      List<Ingredient> ingList = [];
      for (var currentIng in result) {
        Ingredient ing = Ingredient.fromSupaJSON(currentIng);
        ingList.add(ing);
      }
      return ingList;
    }
  }

  Future addNewRecipe(Recipe newItem) async {
    final recipes = await api.getAllRawRecipe(); //NOTE - Get All Recipes to check for a duplicate record
    if (recipes.any((element) => element.name != newItem.name)) {
      print("A Record with same name already exists");
      //FIXME - Create a snackbar or toastification for it
    } else {
      final dynamic result = await api.addNewRawRecipe(newItem);
      //FIXME -  No data is returned. so I get the Null error. So I returned the newly created error.
      return result;
    }
  }

  Future login(String email, String pass) async {
    //FIXME - Should I create a class as USER? 50-50 chance
    final dynamic result = await api.userLoginByEmail(email, pass);
    if (result.runtimeType == AuthResponse) {
      // final Session? session = result.session;
      final User? user = result.user;
      // if (user!.aud == "authenticated" && user.identities!.isNotEmpty) {
      // debugPrint("${user!.identities}");
      // }
      return user;
    } else {
      return result.message;
    }
  }

  Future signup(String email, String pass, String phone) async {
    //FIXME - Should I create a class as USER? 50-50 chance
    final dynamic result = await api.userSignUpByEmail(email, pass, phone);
    if (result.runtimeType == AuthResponse) {
      final User? user = result.user;
      // debugPrint("${user!.identities}");
      return user;
    } else {
      return result.message;
    }
  }

  Future logout() async {
    print("User is Logged out");
    final result = await api.userLogout();
    return result;
  }

  // Stream getRecipeStream() {
  //   final Stream<dynamic> result = api.getRawRecipeAsStream();
  //   return result;
  //   if (result == const Stream.empty()) {
  //     return [Recipe.nullRecipe];
  //   } else {
  //     debugPrint("object");
  //     return const Stream.empty();
  //     // List<Recipe> foodList = [];
  //     // for (var currentFood in result) {
  //     //   Recipe food = Recipe.fromSupaJSON(currentFood);
  //     //   foodList.add(food);
  //     // }
  //     // return foodList;
  //   }
  // }
}
