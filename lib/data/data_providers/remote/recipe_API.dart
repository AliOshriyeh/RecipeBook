import 'package:http/http.dart' as http;

class RecipeAPI {
  Future<http.Response?> getRawRecipeByName(String name) async {
    print("Initializing Data Fetch");
    var url = Uri.https("www.themealdb.com", '/api/json/v1/1/search.php', {'s': name});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<http.Response?> getRawCategories() async {
    print("Initializing Data Fetch");
    var url = Uri.https("www.themealdb.com", '/api/json/v1/1/categories.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
