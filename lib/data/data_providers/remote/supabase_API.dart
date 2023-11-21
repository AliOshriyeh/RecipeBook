import 'dart:async';

import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAPI {
  static const SUPABASE_URL = "https://yzstkoycdvgvubcussyl.supabase.co";
  static const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl6c3Rrb3ljZHZndnViY3Vzc3lsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTcwNTM1NTMsImV4cCI6MjAxMjYyOTU1M30.oWKhLr3hmvLYS0w35YF3JxKHEwq9XAwdzCfCs6j1rTs";

  final supabase = Supabase.instance.client;
  Future getAllRawRecipe() async {
    print("Initializing Supabase Fetch");
    try {
      final query = await Supabase.instance.client.from('Recipes').select();
      return query;
    } on PostgrestException catch (error) {
      //TODO - Make A Toast For it
      print('Request failed with status: ${error.code}');
      // return error;
      rethrow;
    } on ClientException catch (e) {
      print('Request failed: ${e.message}');
      // return error;
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getRawRecipeAsStream() {
    print("Initializing Supabase Streaming");
    try {
      final query = Supabase.instance.client.from('Recipes').stream(primaryKey: ['id']);
      return query;
    } on PostgrestException catch (error) {
      //TODO - Make A Toast For it
      print('Request failed with status: ${error.code}');
      // return error;
      rethrow;
    } on ClientException catch (e) {
      print('Request failed: ${e.message}');
      // return error;
      rethrow;
    }
  }

  // Future addNewRawRecipe(Recipe recipeItem) async {
  //   print("Initializing Supabase Fetch");
  //   try {
  //     final query = await Supabase.instance.client.from('Recipes').insert({
  //       'recipeName': recipeItem.name,
  //       'recipeCategory': recipeItem.category,
  //       'recipeOrigin': recipeItem.origin,
  //       'recipeInstructions': recipeItem.instructions,
  //       'recipeThumb': recipeItem.thumbnail,
  //       'strIngredient1': recipeItem.ingredients[0].isUndefined ? null : recipeItem.ingredients[0],
  //       "strIngredient2": recipeItem.ingredients[1].isUndefined ? null : recipeItem.ingredients[1],
  //       "strIngredient3": recipeItem.ingredients[2].isUndefined ? null : recipeItem.ingredients[2],
  //       "strIngredient4": recipeItem.ingredients[3].isUndefined ? null : recipeItem.ingredients[3],
  //       "strIngredient5": recipeItem.ingredients[4].isUndefined ? null : recipeItem.ingredients[4],
  //       "strIngredient6": recipeItem.ingredients[5].isUndefined ? null : recipeItem.ingredients[5],
  //       "strIngredient7": recipeItem.ingredients[6].isUndefined ? null : recipeItem.ingredients[6],
  //       "strIngredient8": recipeItem.ingredients[7].isUndefined ? null : recipeItem.ingredients[7],
  //       "strIngredient9": recipeItem.ingredients[8].isUndefined ? null : recipeItem.ingredients[8],
  //       "strIngredient10": recipeItem.ingredients[9].isUndefined ? null : recipeItem.ingredients[9],
  //       "strMeasure1": recipeItem.measures[0].isUndefined ? null : recipeItem.measures[0],
  //       "strMeasure2": recipeItem.measures[1].isUndefined ? null : recipeItem.measures[1],
  //       "strMeasure3": recipeItem.measures[2].isUndefined ? null : recipeItem.measures[2],
  //       "strMeasure4": recipeItem.measures[3].isUndefined ? null : recipeItem.measures[3],
  //       "strMeasure5": recipeItem.measures[4].isUndefined ? null : recipeItem.measures[4],
  //       "strMeasure6": recipeItem.measures[5].isUndefined ? null : recipeItem.measures[5],
  //       "strMeasure7": recipeItem.measures[6].isUndefined ? null : recipeItem.measures[6],
  //       "strMeasure8": recipeItem.measures[7].isUndefined ? null : recipeItem.measures[7],
  //       "strMeasure9": recipeItem.measures[8].isUndefined ? null : recipeItem.measures[8],
  //       "strMeasure10": recipeItem.measures[9].isUndefined ? null : recipeItem.measures[9],
  //       "modified_at": DateTime.timestamp()
  //     });
  //     print(query);
  //   } on PostgrestException catch (error) {
  //     //TODO - Make A Toast For it
  //     print('Request failed with status: ${error.code}');
  //     // return error;
  //   } on ClientException catch (e) {
  //     print('Request failed: ${e.message}');
  //     // return error;
  //   }
  // }

  Future getRawRecipeByName(String? name) async {
    print("Initializing Supabase Fetch");
    try {
      final query = await Supabase.instance.client.from('Recipes').select();
      if (name == null) {
        return query;
      } else {
        var filteredQuery = await query.textSearch('recipeName', name);
        return filteredQuery;
      }
    } on PostgrestException catch (error) {
      //TODO - Make A Toast For it
      print(error);
      // return error;
      rethrow;
    } on ClientException catch (e) {
      print("++ ERROR: $e ++");
      // return error;
      rethrow;
    }
  }
}
