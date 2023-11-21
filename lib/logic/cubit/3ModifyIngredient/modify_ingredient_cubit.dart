// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'modify_ingredient_state.dart';

class ModifyIngredientCubit extends Cubit<ModifyIngredientState> {
  ModifyIngredientCubit() : super(ModifyIngredientInitial([]));

  void initialSetup() => emit(ModifyIngredientInitial([]));
  void clearAllIngredient() => emit(ModifyIngredientLoaded([]));

  void refreshIngredient(List<String>? storedList) {
    if (storedList == null) {
      emit(ModifyIngredientLoaded(state.ingredientList)); // In Case of refreshing the Cubit's State
    } else {
      emit(ModifyIngredientLoaded(storedList)); // In Case of recalling already-saved data from database
    }
  }

  void addIngredient(String newIngredient) {
    final state = this.state;
    List<String> newIngredientList = state.ingredientList;
    newIngredientList.add(newIngredient);
    // print(newIngredientList);
    return emit(IngredientAdded(newIngredientList));
  }

  void removeIngredient(String oldIngredient) {
    final state = this.state;
    List<String> newIngredientList = state.ingredientList;
    newIngredientList.remove(oldIngredient);
    // print(newIngredientList);
    return emit(IngredientRemoved(newIngredientList));
  }
}
