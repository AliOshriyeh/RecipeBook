part of 'modify_ingredient_cubit.dart';

sealed class ModifyIngredientState extends Equatable {
  final List<String> ingredientList;
  final List<int> measureList;
  const ModifyIngredientState(this.ingredientList, this.measureList);

  @override
  List<Object> get props => [ingredientList, measureList];
}

final class ModifyIngredientInitial extends ModifyIngredientState {
  const ModifyIngredientInitial(super.ingredientList, super.measureList);
}

final class ModifyIngredientLoaded extends ModifyIngredientState {
  const ModifyIngredientLoaded(super.ingredientList, super.measureList);

  @override
  List<Object> get props => [ingredientList, measureList];
}

final class IngredientAdded extends ModifyIngredientState {
  const IngredientAdded(super.ingredientList, super.measureList);

  @override
  List<Object> get props => [ingredientList, measureList];
}

final class IngredientRemoved extends ModifyIngredientState {
  const IngredientRemoved(super.ingredientList, super.measureList);

  @override
  List<Object> get props => [ingredientList, measureList];
}
