import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test/data/models/recipe_model.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  // final Database recipeDatabase;
  // final _recipeRepo = RecipeRepository();

  RecipeBloc() : super(const RecipeInitial([])) {
    // Upon App StartUp Clear RecipesList.
    on<LoadRecipeEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const RecipeLoaded([]));
    });

    // Upon Adding a New Recipe by User, Add it to RecipesList.
    on<AddRecipeEvent>((event, emit) {
      if (state is RecipeLoaded) {
        final state = this.state as RecipeLoaded;
        emit(RecipeLoaded(List.from(state.recipes)..add(event.recipe)));
      }
    });

    //Upon Removing an Existing Recipe by User, Remove it from RecipesList.
    on<RemoveRecipeEvent>((event, emit) {
      if (state is RecipeLoaded) {
        final state = this.state as RecipeLoaded;
        emit(RecipeLoaded(List.from(state.recipes)..remove(event.recipe)));
      }
    });

    //Upon Editing an Existing Recipe by User, Edit it in RecipesList.
    on<EditRecipeEvent>((event, emit) {
      if (state is RecipeLoaded) {
        final state = this.state as RecipeLoaded;
        //Get Index of Existing Recipe
        final index = state.recipes.indexWhere((recipeElement) => recipeElement.id == event.recipe.id);

        emit(RecipeLoaded(List.from(state.recipes)
          ..removeAt(index)
          ..insert(index, event.recipe)));
      }
    });
  }

  // List<Recipe> _recipes = [];
  // List<Recipe> get recipes => _recipes;

  // Future<void> getRecipes() async {
  //   await _recipeRepo.getRecipe(recipeDatabase);
  // }
}
