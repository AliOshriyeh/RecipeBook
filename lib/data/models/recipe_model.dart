// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:test/data/data_providers/local/sqflite_prov.dart';

class Recipe extends Equatable {
  final int? id;
  final String name;
  final bool isVegan;
  final String category;
  final String instructions;
  final String? thumbnail;

  const Recipe({
    this.id,
    required this.name,
    required this.isVegan,
    required this.category,
    required this.instructions,
    this.thumbnail,
  });

  @override
  List<Object?> get props => [id, name, isVegan, instructions, category, thumbnail];

  //Converting App Object to Database Item
  //Sqflite Doesn't has any boolean type. Proceed with caution!
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      // DatabaseProvider.COLUMN_ID: id,
      //Because We are working with Sqflite-Given-ID for every item.
      // I decided to leave id blank and fill it when insert-operation is done and the item's id is generated! Smart Right :)
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_CATEGORY: category,
      DatabaseProvider.COLUMN_INSTRUCTIONS: instructions,
      DatabaseProvider.COLUMN_VEGAN: isVegan ? 1 : 0,
    };
    // map.forEach((key, value) => print("$key -> $value AS ${value.runtimeType}"));
    return map;
  }

  //Converting Database Item to App Object
  Recipe fromMap(Map<String, dynamic> map) {
    var queryid = map[DatabaseProvider.COLUMN_ID];
    var queryname = map[DatabaseProvider.COLUMN_NAME];
    var querycategory = map[DatabaseProvider.COLUMN_CATEGORY];
    var querycontent = map[DatabaseProvider.COLUMN_INSTRUCTIONS];
    var queryisvegan = map[DatabaseProvider.COLUMN_VEGAN] == 1 ? true : false;

    // map.forEach((key, value) => print("$key -> $value AS ${value.runtimeType}"));
    return Recipe(id: queryid, name: queryname, isVegan: queryisvegan, category: querycategory, instructions: querycontent);
  }

  //Converting Database Item to App Object
  factory Recipe.fromJSON(Map<String, dynamic> jsonRecipe) {
    var serverid = int.parse(jsonRecipe['idMeal']);
    var servername = jsonRecipe['strMeal'];
    var servercategory = jsonRecipe['strCategory'];
    var serverthumbnail = jsonRecipe['strMealThumb'];
    var serverinstructions = jsonRecipe['strInstructions'];

    return Recipe(id: serverid, name: servername, isVegan: false, category: servercategory, instructions: serverinstructions, thumbnail: serverthumbnail);
  }

  static Recipe nullRecipe = const Recipe(
    id: -1,
    name: "NULL",
    isVegan: false,
    instructions: "NULL",
    category: "NULL",
    thumbnail: "NULL",
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
