// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:test/data/data_providers/local/sqflite_prov.dart';

//Sqflite Doesn't has any boolean type. ⁡⁢⁣⁢𝗣𝗿𝗼𝗰𝗲𝗲𝗱 𝘄𝗶𝘁𝗵 𝗰𝗮𝘂𝘁𝗶𝗼𝗻!⁡
class Recipe extends Equatable {
  final int? id;
  final String name;
  final String origin;
  final String category;
  final String? thumbnail;
  final String instructions;
  final List<dynamic> measures;
  final List<String> ingredients;
  final bool authorization;

  const Recipe({
    this.id,
    required this.name,
    required this.origin,
    required this.category,
    required this.measures,
    required this.thumbnail,
    required this.ingredients,
    required this.instructions,
    required this.authorization,
  });

  @override
  List<Object?> get props => [id, name, origin, category, ingredients, measures, instructions, thumbnail, authorization];

  //Converting App Object to Database Item⁡
  Map<String, dynamic> toMap() {
    // Since I cant Convert a List<String> to a Str ⁡⁢⁣⁢Directly⁡,
    // I will just do with iterating List's Elements and adding them to Str One At a Time⁡!
    String measuresSuperStr = measures.join('|');
    String ingredientsSuperStr = ingredients.join('|');

    var map = <String, dynamic>{
      // Because We are working with Sqflite-Given-ID for every item.
      // I decided to leave id blank and fill it when insert-operation is done
      // and after when item's id is generated! ⁡⁢⁣⁣Smart Right? :)⁡
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_ORIGIN: origin,
      DatabaseProvider.COLUMN_CATEGORY: category,
      DatabaseProvider.COLUMN_MEASURES: measuresSuperStr,
      DatabaseProvider.COLUMN_THUMBNAIL: thumbnail,
      DatabaseProvider.COLUMN_INSTRUCTION: instructions,
      DatabaseProvider.COLUMN_INGREDIENTS: ingredientsSuperStr,
      // DatabaseProvider.COLUMN_AUTHORIZATION: authorization, //FIXME - The Local Database doesn't support authorization for now.
      // DatabaseProvider.COLUMN_ID: id,
    };

    // map.forEach((key, value) => debugPrint("$key -> $value AS ${value.runtimeType}"));
    return map;
  }

  //Converting Database Item to App Object
  Recipe fromMap(Map<String, dynamic> map) {
    var queryid = map[DatabaseProvider.COLUMN_ID];
    var queryname = map[DatabaseProvider.COLUMN_NAME];
    var queryorigin = map[DatabaseProvider.COLUMN_ORIGIN];
    var querycategory = map[DatabaseProvider.COLUMN_CATEGORY];
    var querymeasures = map[DatabaseProvider.COLUMN_MEASURES];
    var querythumbnail = map[DatabaseProvider.COLUMN_THUMBNAIL];
    var queryingredients = map[DatabaseProvider.COLUMN_INGREDIENTS];
    var queryinstruction = map[DatabaseProvider.COLUMN_INSTRUCTION];
    // var queryauthorization = map[DatabaseProvider.COLUMN_AUTHORIZATION];

    var querymeasuresList = querymeasures.toString().split('|');
    var queryingredientsList = queryingredients.toString().split('|');

    // map.forEach((key, value) => debugPrint("$key -> $value AS ${value.runtimeType}"));
    return Recipe(id: queryid, name: queryname, origin: queryorigin, category: querycategory, instructions: queryinstruction, ingredients: queryingredientsList, thumbnail: querythumbnail, measures: querymeasuresList, authorization: false);
  }

  //Parsing Supabase Item to App Object
  factory Recipe.fromSupaJSON(Map<String, dynamic> jsonRecipe) {
    var supadid = jsonRecipe['recipeId'];
    var supadname = jsonRecipe['recipeName'];
    var supadorigin = jsonRecipe['recipeOrigin'];
    var supadcategory = jsonRecipe['recipeCategory'];
    var supadthumbnail = jsonRecipe['recipeThumb'] ?? 'NULL';
    var supadinstructions = jsonRecipe['recipeInstructions'];
    // var supadmodifieddate = jsonRecipe['modified_at'];
    var supadingredientarray = List<String>.from(jsonRecipe['strIngredients'] ?? []);
    var supadmeasurearray = List<String>.from(jsonRecipe['strMeasures'] ?? []);
    var supaauthorization = jsonRecipe['recipeConfirmation'] ?? false;

    var result = Recipe(id: supadid, name: supadname, origin: supadorigin, category: supadcategory, ingredients: supadingredientarray, instructions: supadinstructions, measures: supadmeasurearray, thumbnail: supadthumbnail, authorization: supaauthorization);
    return result;
  }

  //Parsing Fake API Item to App Object //FIXME - Delete when build a new showcase in homepage
  factory Recipe.fromJSON(Map<String, dynamic> jsonRecipe) {
    var storedid = int.parse(jsonRecipe['idMeal']);
    var storedname = jsonRecipe['strMeal'];
    var storedorigin = jsonRecipe['strArea'];
    var storedcategory = jsonRecipe['strCategory'];
    var storedthumbnail = jsonRecipe['strMealThumb'];
    var storedinstructions = jsonRecipe['strInstructions'];

    List<String> storedingredients = [];
    storedingredients.add(jsonRecipe['strIngredient1']);
    storedingredients.add(jsonRecipe['strIngredient2']);
    storedingredients.add(jsonRecipe['strIngredient3']);
    storedingredients.add(jsonRecipe['strIngredient4']);
    storedingredients.add(jsonRecipe['strIngredient5']);
    storedingredients.add(jsonRecipe['strIngredient6']);
    storedingredients.add(jsonRecipe['strIngredient7']);
    storedingredients.add(jsonRecipe['strIngredient8']);
    storedingredients.add(jsonRecipe['strIngredient9']);
    storedingredients.add(jsonRecipe['strIngredient10']);

    return Recipe(id: storedid, name: storedname, origin: storedorigin, category: storedcategory, ingredients: storedingredients, instructions: storedinstructions, thumbnail: storedthumbnail, measures: [], authorization: true);
  }

  static Recipe nullRecipe = const Recipe(
    id: -1,
    name: 'No Name Specified',
    origin: 'Of no Origin',
    category: 'Not Selected',
    measures: [],
    ingredients: [],
    instructions: 'No Instructions',
    thumbnail: 'NULL',
    authorization: false,
  );
}
