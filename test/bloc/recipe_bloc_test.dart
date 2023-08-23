import 'package:flutter_test/flutter_test.dart';
import 'package:test/logic/bloc/recipe_bloc.dart';

void main() {
  group("Recipe Bloc", () {
    RecipeBloc recipeBloc = RecipeBloc();
    tearDown(() => recipeBloc.close());

    test("The Initial State for the Recipe Book", () {
      expect(recipeBloc.state, const RecipeInitial([]));
    });
    // test("The Loaded State for the Recipe Book", () {
    //   expect(recipeBloc.state, RecipeLoaded(recipes: recipeBloc.state.props.first as List<Recipe>));
    // });
  });
}
