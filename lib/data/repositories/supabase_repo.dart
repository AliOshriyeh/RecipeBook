import 'package:test/data/data_providers/remote/supabase_API.dart';
import 'package:test/data/models/recipe_model.dart';

class SupaRecipeRepository {
  final SupabaseAPI api = SupabaseAPI();

  Future<List<Recipe>> getAllRecipe() async {
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

  Stream getRecipeStream() {
    final Stream<dynamic> result = api.getRawRecipeAsStream();
    return result;
    // if (result == const Stream.empty()) {
    //   return [Recipe.nullRecipe];
    // } else {
    //   print("object");
    //   return const Stream.empty();
    //   // List<Recipe> foodList = [];
    //   // for (var currentFood in result) {
    //   //   Recipe food = Recipe.fromSupaJSON(currentFood);
    //   //   foodList.add(food);
    //   // }
    //   // return foodList;
    // }
  }

  Future addNewRecipe(Recipe newItem) async {
    //<List<Recipe>>
    // final List<dynamic> result =
    // await api.addNewRawRecipe(newItem);
    // if (result.isEmpty) {
    //   return [Recipe.nullRecipe];
    // } else {
    //   List<Recipe> foodList = [];
    //   for (var currentFood in result) {
    //     Recipe food = Recipe.fromSupaJSON(currentFood);
    //     foodList.add(food);
    //   }
    //   return foodList;
    // }
  }
}
