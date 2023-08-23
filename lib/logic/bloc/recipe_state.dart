part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  final List<Recipe> recipes;
  const RecipeState(this.recipes);

  @override
  List<Object> get props => [];
}

//State Designed for APP StartUp
class RecipeInitial extends RecipeState {
  const RecipeInitial(super.recipes);
}

//State Designed for READY-TO-USE APP
class RecipeLoaded extends RecipeState {
  const RecipeLoaded(super.recipes);

  @override
  List<Object> get props => [recipes];
}
