part of 'online_cookbook_bloc.dart';

abstract class OnlineCookBookState extends Equatable {
  final List<Recipe> recipes;
  final List<Ingredient> ingredients;
  const OnlineCookBookState(this.recipes, this.ingredients);

  @override
  List<Object> get props => [recipes];
}

//State Designed for API StartUp
final class OnlineCookBookIdle extends OnlineCookBookState {
  const OnlineCookBookIdle(super.recipes, super.ingredients);
}

//State Designed for READY-TO-USE API
class OnlineCookBookLoaded extends OnlineCookBookState {
  const OnlineCookBookLoaded(super.recipes, super.ingredients);

  @override
  List<Object> get props => [recipes, ingredients];
}
