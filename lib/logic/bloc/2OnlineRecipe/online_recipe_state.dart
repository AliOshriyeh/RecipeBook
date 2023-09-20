part of 'online_recipe_bloc.dart';

abstract class OnlineRecipeState extends Equatable {
  final List<Recipe> recipes;
  const OnlineRecipeState(this.recipes);

  @override
  List<Object> get props => [recipes];
}

//State Designed for API StartUp
final class OnlineRecipeInitial extends OnlineRecipeState {
  const OnlineRecipeInitial(super.recipes);
}

//State Designed for LOADING the API
class OnlineRecipeLoading extends OnlineRecipeState {
  const OnlineRecipeLoading(super.recipes);
}

//State Designed for READY-TO-USE API
class OnlineRecipeLoaded extends OnlineRecipeState {
  const OnlineRecipeLoaded(super.recipes);

  @override
  List<Object> get props => [recipes];
}
