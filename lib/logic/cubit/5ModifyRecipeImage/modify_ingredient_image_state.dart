part of 'modify_ingredient_image_cubit.dart';

sealed class ModifyRecipeImageState extends Equatable {
  final String selectedImagePath;
  const ModifyRecipeImageState(this.selectedImagePath);

  @override
  List<Object> get props => [selectedImagePath];
}

final class ModifyRecipeImageInitial extends ModifyRecipeImageState {
  const ModifyRecipeImageInitial(super.selectedImagePath);
}

final class ModifyRecipeImageLoaded extends ModifyRecipeImageState {
  const ModifyRecipeImageLoaded(super.selectedImagePath);

  @override
  List<Object> get props => [selectedImagePath];
}

final class RecipeImageAdded extends ModifyRecipeImageState {
  const RecipeImageAdded(super.selectedImagePath);

  @override
  List<Object> get props => [selectedImagePath];
}

final class RecipeImageRemoved extends ModifyRecipeImageState {
  const RecipeImageRemoved(super.selectedImagePath);

  @override
  List<Object> get props => [selectedImagePath];
}
