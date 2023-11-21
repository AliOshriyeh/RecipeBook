part of 'modify_ingredient_cubit.dart';

sealed class ModifyIngredientState extends Equatable {
  final List<String> ingredientList;
  const ModifyIngredientState(this.ingredientList);

  @override
  List<Object> get props => [ingredientList];
}

final class ModifyIngredientInitial extends ModifyIngredientState {
  const ModifyIngredientInitial(super.ingredientList);
}

final class ModifyIngredientLoaded extends ModifyIngredientState {
  const ModifyIngredientLoaded(super.ingredientList);

  @override
  List<Object> get props => [ingredientList];
}

final class IngredientAdded extends ModifyIngredientState {
  const IngredientAdded(super.ingredientList);

  @override
  List<Object> get props => [ingredientList];
}

final class IngredientRemoved extends ModifyIngredientState {
  const IngredientRemoved(super.ingredientList);

  @override
  List<Object> get props => [ingredientList];
}
