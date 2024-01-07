import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/data/models/recipe_model.dart';

class SupabaseAPI {
  static const SUPABASE_URL = "https://yzstkoycdvgvubcussyl.supabase.co";
  static const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl6c3Rrb3ljZHZndnViY3Vzc3lsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTcwNTM1NTMsImV4cCI6MjAxMjYyOTU1M30.oWKhLr3hmvLYS0w35YF3JxKHEwq9XAwdzCfCs6j1rTs";

  final supabase = Supabase.instance.client;

  Future getAllRawRecipe() async {
    debugPrint("Initializing Supabase Fetch #Recipes");
    try {
      final query = await Supabase.instance.client.from('Recipes').select().order('recipeId', ascending: true);
      return query;
    } on PostgrestException catch (error) {
      //TODO - Make A Toast For it
      debugPrint('Request failed with status: ${error.code}');
      // return error;
      rethrow;
    } on ClientException catch (e) {
      debugPrint('Request failed: ${e.message}');
      // return error;
      rethrow;
    }
  }

  Future getAllRawIngredient() async {
    debugPrint("Initializing Supabase Fetch #Ingredients");
    try {
      final query = await Supabase.instance.client.from('Ingredients').select();
      return query;
    } on PostgrestException catch (error) {
      //TODO - Make A Toast For it
      debugPrint('Request failed with status: ${error.code}');
      // return error;
      rethrow;
    } on ClientException catch (e) {
      debugPrint('Request failed: ${e.message}');
      // return error;
      rethrow;
    }
  }

  Future addNewRawRecipe(Recipe recipeItem) async {
    debugPrint("Initializing Supabase Upload #Recipes");
    try {
      // var newId = (await getAllRawRecipe()).last['recipeId'];
      var newRecipe = await Supabase.instance.client.from('Recipes').insert({
        // 'recipeId': newId,
        'recipeName': recipeItem.name,
        'recipeCategory': recipeItem.category,
        'recipeOrigin': recipeItem.origin,
        'recipeInstructions': recipeItem.instructions,
        'recipeThumb': recipeItem.thumbnail,
        'strIngredients': recipeItem.ingredients,
        'strMeasures': recipeItem.measures,
        "modified_at": DateTime.timestamp().toString(),
        "recipeConfirmation": recipeItem.authorization,
      }).select();
      return newRecipe;
    } on PostgrestException catch (error) {
      //TODO - Make A Toast For it
      debugPrint('Request failed with status: ${error.code}');
      return error;
    } on ClientException catch (error) {
      debugPrint('Request failed: ${error.message}');
      return error;
    }
  }

  Future userLoginByEmail(String email, String pass) async {
    debugPrint("Initializing Supabase Login #Email");
    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(email: email, password: pass);
      return response;
    } on AuthException catch (error) {
      debugPrint('Request failed: ${error.message}');
      //FIXME - Make a better notification
      return error;
    } on ClientException catch (error) {
      debugPrint('Request failed: ${error.message}');
      return error;
    } catch (error) {
      debugPrint(error.toString());
      return error;
    }
  }

  Future userSignUpByEmail(String email, String pass, String phone) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(email: email, /*phone: phone,*/ password: pass, channel: OtpChannel.sms);
      return response;
    } on AuthException catch (error) {
      debugPrint('Request failed: ${error.message}');
      //FIXME - Make a better notification
      return error;
    } on ClientException catch (error) {
      debugPrint('Request failed: ${error.message}');
      return error;
    } catch (error) {
      debugPrint(error.toString());
      return error;
    }

    // print('RESPONSE $res');
    // final Session? session = res.session;
    // print('SESSion $session');
    // final User? user = res.user;
    // print('USER $user');
  }

  Future userLogout() async {
    debugPrint("Initializing Supabase Log Out");
    final response = await supabase.auth.signOut();
    // final response = await supabase.dispose();
    return response;
  }

  Future getRawRecipeByName(String? name) async {
    debugPrint("Initializing Supabase Fetch");
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
      debugPrint(error.toString());
      // return error;
      rethrow;
    } on ClientException catch (e) {
      debugPrint("++ ERROR: $e ++");
      // return error;
      rethrow;
    }
  }

  // Stream<List<Map<String, dynamic>>> getRawRecipeAsStream() {
  //   debugPrint("Initializing Supabase Streaming");
  //   try {
  //     final query = Supabase.instance.client.from('Recipes').stream(primaryKey: ['id']);
  //     return query;
  //   } on PostgrestException catch (error) {
  //     //TODO - Make A Toast For it
  //     debugPrint('Request failed with status: ${error.code}');
  //     // return error;
  //     rethrow;
  //   } on ClientException catch (e) {
  //     debugPrint('Request failed: ${e.message}');
  //     // return error;
  //     rethrow;
  //   }
  // }
}
