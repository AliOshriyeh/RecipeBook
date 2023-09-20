part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  final Recipe recipe;
  const RecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

//Event Designed for READING The Elements
class LoadRecipeEvent extends RecipeEvent {
  const LoadRecipeEvent(super.recipe);
}

//Event Designed for CREATING New Elements
class AddRecipeEvent extends RecipeEvent {
  const AddRecipeEvent(super.recipe);
}

//Event Designed for DELETING The Elements
class RemoveRecipeEvent extends RecipeEvent {
  const RemoveRecipeEvent(super.recipe);
}

//Event Designed for UPDATING The Elements
class EditRecipeEvent extends RecipeEvent {
  const EditRecipeEvent(super.recipe);
}

//Event Designed for UPDATING The Elements
class GetRecipeEvent extends RecipeEvent {
  const GetRecipeEvent(super.recipe);
}
