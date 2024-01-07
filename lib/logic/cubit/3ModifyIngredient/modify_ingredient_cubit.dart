// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'modify_ingredient_state.dart';

class ModifyIngredientCubit extends Cubit<ModifyIngredientState> {
  ModifyIngredientCubit() : super(ModifyIngredientInitial([], []));

  void initialSetup() => emit(ModifyIngredientInitial([], []));
  void clearAllIngredient() => emit(ModifyIngredientLoaded([], []));

  void reloadIngredients(List<String>? storedIngList, List<int>? storedMsrList) {
    if (storedIngList == null) {
      //Just for Reload Purpose - resend the list
      emit(ModifyIngredientLoaded(state.ingredientList, state.measureList)); // In Case of refreshing the Cubit's State
    } else {
      //If something changed
      emit(ModifyIngredientLoaded(storedIngList, storedMsrList ?? state.measureList)); // In Case of recalling already-saved data from database
    }
  }

  void addIngredient(int index) {
    final state = this.state;
    List<int> newMeasureList = state.measureList;
    newMeasureList[index] = newMeasureList[index] + 1;
    // debugPrint(newMeasureList[index]);
    return emit(IngredientAdded(state.ingredientList, newMeasureList));
  }

  void removeIngredient(int index) {
    final state = this.state;
    List<int> newMeasureList = state.measureList;
    newMeasureList[index] = newMeasureList[index] - 1;
    // debugPrint(newMeasureList[index]);
    return emit(IngredientAdded(state.ingredientList, newMeasureList));
  }
}
