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
  final List<String> measures;
  final List<String> ingredients;
  // final bool isVegan;

  const Recipe({
    this.id,
    required this.name,
    required this.origin,
    required this.category,
    required this.measures,
    required this.thumbnail,
    required this.ingredients,
    required this.instructions,
    // required this.isVegan,
  });

  @override
  List<Object?> get props => [id, name, origin, category, ingredients, instructions, thumbnail, measures]; //isVegan

  //Converting App Object to Database Item⁡
  Map<String, dynamic> toMap() {
    // Since I cant Convert a List<String> to a Str ⁡⁢⁣⁢Directly⁡,
    // I will just do with iterating List's Elements and adding them to Str One At a Time⁡!
    String ingredientSuperStr = ingredients.join('|');

    var map = <String, dynamic>{
      // Because We are working with Sqflite-Given-ID for every item.
      // I decided to leave id blank and fill it when insert-operation is done
      // and the item's id is generated! ⁡⁢⁣⁣Smart Right? :)⁡
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_ORIGIN: origin,
      DatabaseProvider.COLUMN_CATEGORY: category,
      DatabaseProvider.COLUMN_THUMBNAIL: thumbnail,
      DatabaseProvider.COLUMN_INSTRUCTION: instructions,
      DatabaseProvider.COLUMN_INGREDIENTS: ingredientSuperStr,
      // DatabaseProvider.COLUMN_ID: id,
      // DatabaseProvider.COLUMN_VEGAN: isVegan ? 1 : 0,
    };

    // map.forEach((key, value) => print("$key -> $value AS ${value.runtimeType}"));
    return map;
  }

  //Converting Database Item to App Object
  Recipe fromMap(Map<String, dynamic> map) {
    var queryid = map[DatabaseProvider.COLUMN_ID];
    var queryname = map[DatabaseProvider.COLUMN_NAME];
    var queryorigin = map[DatabaseProvider.COLUMN_ORIGIN];
    var querycategory = map[DatabaseProvider.COLUMN_CATEGORY];
    var querythumbnail = map[DatabaseProvider.COLUMN_THUMBNAIL];
    var queryingredients = map[DatabaseProvider.COLUMN_INGREDIENTS];
    var queryinstruction = map[DatabaseProvider.COLUMN_INSTRUCTION];
    // var queryisvegan = map[DatabaseProvider.COLUMN_VEGAN] == 1 ? true : false;

    var queryingredientsList = queryingredients.toString().split('|');

    // map.forEach((key, value) => print("$key -> $value AS ${value.runtimeType}"));
    return Recipe(id: queryid, name: queryname, origin: queryorigin, category: querycategory, instructions: queryinstruction, ingredients: queryingredientsList, thumbnail: querythumbnail, measures: []); //isVegan: queryisvegan
  }

  //Parsing Supabase Item to App Object
  factory Recipe.fromSupaJSON(Map<String, dynamic> jsonRecipe) {
    var supadid = jsonRecipe['recipeId'];
    var supadname = jsonRecipe['recipeName'];
    var supadorigin = jsonRecipe['recipeOrigin'];
    var supadcategory = jsonRecipe['recipeCategory'];
    var supadthumbnail = jsonRecipe['recipeThumb'] ?? "Null";
    var supadinstructions = jsonRecipe['recipeInstructions'];
    // var supadcreateddate = jsonRecipe['created_at'];
    // var supadmodifieddate = jsonRecipe['modified_at'];
    var supadingredientarray = List<String>.from(jsonRecipe['strIngredients'] ?? []);

    // List<String> supadingredients = [];
    // supadingredients.add(jsonRecipe['strIngredient1'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient2'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient3'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient4'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient5'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient6'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient7'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient8'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient9'] ?? "");
    // supadingredients.add(jsonRecipe['strIngredient10'] ?? "");

    List<String> supadmeasures = [];
    supadmeasures.add(jsonRecipe['strMeasure1'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure2'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure3'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure4'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure5'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure6'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure7'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure8'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure9'] ?? "");
    supadmeasures.add(jsonRecipe['strMeasure10'] ?? "");

    var result = Recipe(id: supadid, name: supadname, origin: supadorigin, category: supadcategory, ingredients: supadingredientarray, instructions: supadinstructions, measures: supadmeasures, thumbnail: supadthumbnail); //isVegan: false,
    return result;
  }

  //Parsing Network Item to App Object
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

    return Recipe(id: storedid, name: storedname, origin: storedorigin, category: storedcategory, ingredients: storedingredients, instructions: storedinstructions, thumbnail: storedthumbnail, measures: []); //isVegan: false,
  }

  static Recipe nullRecipe = const Recipe(
    id: -1,
    name: "NULL",
    origin: "NULL",
    category: "NULL",
    measures: [],
    ingredients: [],
    instructions: "NULL",
    thumbnail: "NULL",
    // isVegan: false,
  );

  //!DUMMY DATA
  // static List<Recipe> recipes = [
  //   Recipe(
  //       id: '0',
  //       image: Image.asset('assets/images/Re1_zucchini_slice.jpg', fit: BoxFit.cover),
  //       name: "Zucchini Slice",
  //       instructions: "While the argument as to what is Australia’s national dish will always rage (is it roast lamb, green chicken curry or a barramundi burger)? One thing is for sure, zucchini slice is hands-down the national food of the home cook."),
  //   Recipe(
  //       id: '1',
  //       image: Image.asset('assets/images/Re2_pumpkin_soup.jpg', fit: BoxFit.cover),
  //       name: "Easy pumpkin soup recipe",
  //       instructions: "The beauty of pumpkin soup _ and this classic pumpkin soup recipe in particular - is that it’s so versatile and forgiving. It’s one of the easiest meals to make with just a handful of ingredients, and it’s almost impossible to mess up."),
  //   Recipe(
  //       id: '2',
  //       image: Image.asset('assets/images/Re3_fried_rice.jpg', fit: BoxFit.cover),
  //       name: "Easy fried rice",
  //       instructions: "Fried rice is a staple of Aussie takeaway and while we all have our favourite restaurant that makes it just the way we like it, it's a dish that is easy to replicate at home. "),
  //   Recipe(
  //       id: '3',
  //       image: Image.asset('assets/images/Re4_shepherds_pie.jpg', fit: BoxFit.cover),
  //       name: "Classic shepherd's pie",
  //       instructions: "A classic British and Irish dish that’s loved the world over, shepherd’s pie is the ultimate comfort food. Made with lamb mince, a rich gravy and buttery mashed potatoes, this recipe has all the elements for a perfect Sunday dinner"),
  //   Recipe(
  //       id: '4',
  //       image: Image.asset('assets/images/Re5_impossible_quiche.jpg', fit: BoxFit.cover),
  //       name: "Impossible quiche",
  //       instructions: "Don’t let the name deceive you: this ham and cheese quiche is actually incredibly possible to make. What we love about impossible quiche is that it requires no puff pastry base - you simply mix all the ingredients together, pour into the dish and voila!"),
  // ];
}
