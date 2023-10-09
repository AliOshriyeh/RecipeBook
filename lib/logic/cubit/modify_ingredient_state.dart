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

final class ModifyIngredientAdded extends ModifyIngredientState {
  const ModifyIngredientAdded(super.ingredientList);

  @override
  List<Object> get props => [ingredientList];
}

final class ModifyIngredientLoaded extends ModifyIngredientState {
  const ModifyIngredientLoaded(super.ingredientList);

  @override
  List<Object> get props => [ingredientList];
}
