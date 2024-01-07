// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'modify_ingredient_image_state.dart';

class ModifyRecipeImageCubit extends Cubit<ModifyRecipeImageState> {
  ModifyRecipeImageCubit() : super(ModifyRecipeImageInitial('NULL'));

  void initialSetup() => emit(ModifyRecipeImageInitial('NULL'));
  void removeImage() => emit(ModifyRecipeImageLoaded('NULL'));

  void addRecipeImageFromGallary() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      emit(RecipeImageAdded('NULL'));
    } else {
      emit(RecipeImageAdded(pickedImage.path));
    }
  }

  void addRecipeImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      emit(RecipeImageAdded('NULL'));
    } else {
      emit(RecipeImageAdded(pickedImage.path));
    }
  }

  void loadImagePath(String? imagePath) {
    if (imagePath == null) {
      emit(ModifyRecipeImageLoaded('NULL')); // In Case of loading a Recipe with no Image
    } else {
      emit(ModifyRecipeImageLoaded(imagePath)); // To Load Image When Opening Edit_Recipe_Dialog
    }
  }
  // Future _pickImageFromGallary() async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage == null) {
  //     return;
  //   } else {
  //     return File(pickedImage.path);
  //   }
  // }

  // Future _pickImageFromCamera() async {
  //   final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (pickedImage == null) return;
  //   setState(() {
  //     _selectedImage = File(pickedImage.path);
  //   });
  // }
}
