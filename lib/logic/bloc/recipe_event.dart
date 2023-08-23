part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

//Event Designed for READING The Elements
class LoadRecipeEvent extends RecipeEvent {}

//Event Designed for CREATING New Elements
class AddRecipeEvent extends RecipeEvent {
  final Recipe recipe;
  const AddRecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

//Event Designed for DELETING The Elements
class RemoveRecipeEvent extends RecipeEvent {
  final Recipe recipe;
  const RemoveRecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

//Event Designed for UPDATING The Elements
class EditRecipeEvent extends RecipeEvent {
  final Recipe recipe;
  const EditRecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}
