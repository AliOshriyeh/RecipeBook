import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeAPI {
  Future<http.Response?> getRawRecipeByName(String name) async {
    debugPrint("Initializing Data Fetch #Recipes.Showcase");
    var url = Uri.https("www.themealdb.com", '/api/json/v1/1/search.php', {'s': name});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<http.Response?> getRawCategories() async {
    debugPrint("Initializing Data Fetch #Categories.Showcase");
    var url = Uri.https("www.themealdb.com", '/api/json/v1/1/categories.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
