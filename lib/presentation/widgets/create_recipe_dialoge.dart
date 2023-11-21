// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/logic/cubit/5ModifyRecipeImage/modify_ingredient_image_cubit.dart';
import 'package:test/utils/constants/constLists.dart';
import 'package:test/logic/bloc/1Recipe/recipe_bloc.dart';
import 'package:test/logic/cubit/3ModifyIngredient/modify_ingredient_cubit.dart';
import 'package:toastification/toastification.dart';

class CreateRecipeDialog extends StatefulWidget {
  const CreateRecipeDialog({super.key});

  @override
  State<CreateRecipeDialog> createState() => _CreateRecipeDialogState();
}

class _CreateRecipeDialogState extends State<CreateRecipeDialog> {
  // bool isVegan = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller_name = TextEditingController();
  TextEditingController controller_content = TextEditingController();
  TextEditingController controller_country = TextEditingController();
  TextEditingController controller_category = TextEditingController();
  TextEditingController controller_ingredient = TextEditingController();

  List<DropdownMenuEntry> categoryEntry = categoryList.map((element) => DropdownMenuEntry(value: element, label: element)).toList();
  List<DropdownMenuEntry> countryEntry = countryList.map((element) => DropdownMenuEntry(value: element, label: element)).toList();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: AlertDialog(
      scrollable: true,
      iconPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      icon: Align(alignment: Alignment.topRight, child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded, color: Colors.red))),
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<ModifyRecipeImageCubit, ModifyRecipeImageState>(
          builder: (context, imageState) {
            ModifyRecipeImageCubit recipeImageCubit = context.read<ModifyRecipeImageCubit>();
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: recipeImageCubit.state.selectedImagePath == "NULL",
                  child: FloatingActionButton.small(onPressed: () => recipeImageCubit.addRecipeImageFromCamera(), child: const Icon(Icons.camera_alt_rounded)),
                ),
                recipeImageCubit.state.selectedImagePath == "NULL"
                    ? CircleAvatar(
                        maxRadius: 70,
                        backgroundColor: Colors.amber.shade400,
                        child: const Icon(Icons.local_dining_rounded, size: 85, color: Colors.white60),
                      )
                    : CircleAvatar(maxRadius: 70, foregroundImage: FileImage(File(imageState.selectedImagePath))),
                Visibility(
                  visible: recipeImageCubit.state.selectedImagePath == "NULL",
                  child: FloatingActionButton.small(onPressed: () => recipeImageCubit.addRecipeImageFromGallary(), child: const Icon(Icons.image_search_rounded)),
                ),
              ],
            );
          },
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            controller: controller_name,
            validator: (value) => (value == null || value.length < 4) ? "Enter A Valid Name" : null,
            decoration: InputDecoration(
                hintText: "Name Your Dish :)",
                contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 8),
          // TextFormField(
          //   controller: controller_category,
          //   inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
          //   keyboardType: TextInputType.number,
          //   validator: (value) => (value == null || int.parse(value) < 300) ? "Amount is Too Low" : null,
          //   decoration: InputDecoration(
          //       hintText: "How Much Calories It Has?",
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          //       focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
          //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
          // ),
          // const SizedBox(height: 8),
          DropdownMenu(
              dropdownMenuEntries: categoryEntry,
              controller: controller_category,
              hintText: "Assign Category",
              inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0),
              ))),
          const SizedBox(height: 8),
          DropdownMenu(
              dropdownMenuEntries: countryEntry,
              controller: controller_country,
              hintText: "Assign Origin",
              inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0),
              ))),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller_ingredient,
            onTap: () => controller_ingredient.clear(),
            keyboardType: TextInputType.text,
            // validator: (value) => (value == null || value.length < 3) ? "Enter A Valid Ingredient" : null,
            onFieldSubmitted: (newValue) async {
              if (newValue.length > 2) {
                ModifyIngredientCubit ingredientCubit = context.read<ModifyIngredientCubit>(); // BlocProvider.of<ModifyIngredientCubit>(context);
                ingredientCubit.addIngredient(newValue);
                ingredientCubit.refreshIngredient(null);
                controller_ingredient.clear();
              } else {
                controller_ingredient.text = "Enter A Valid Ingredient";
              }
            },
            decoration: InputDecoration(
                hintText: "Add Ingredients",
                contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 8),
          BlocBuilder<ModifyIngredientCubit, ModifyIngredientState>(
            builder: (context, ingredientstate) {
              List<Widget> ingredientEntry = ingredientstate.ingredientList.map((element) => Chip(label: Text(element))).toList();
              // print("Ingredients: ${ingredientstate.ingredientList}");

              return Wrap(spacing: 5, children: ingredientEntry);
            },
          ),

          const SizedBox(height: 8),
          TextFormField(
            maxLines: 5,
            maxLength: 300,
            controller: controller_content,
            keyboardType: TextInputType.multiline,
            validator: (value) => (value == null || value.length < 20) ? "Recipe is TOO Short!!" : null,
            decoration: InputDecoration(
                hintText: "Explain How To Make it!",
                contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
          ),
          // SwitchListTile(title: const Text("Is Vegan"), activeColor: Colors.greenAccent, value: isVegan, onChanged: (bool value) => setState(() => isVegan = value))
        ]),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton.icon(
              style: TextButton.styleFrom(elevation: 5, backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 12)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ModifyIngredientState newstate = context.read<ModifyIngredientCubit>().state as ModifyIngredientLoaded; //BlocProvider.of<ModifyIngredientCubit>(context).state as ModifyIngredientLoaded;
                  ModifyRecipeImageState imagestate = context.read<ModifyRecipeImageCubit>().state; // BlocProvider.of<ModifyRecipeImageCubit>(context).state;
                  Recipe queryRecipe = Recipe(
                    // isVegan: isVegan,
                    name: controller_name.text,
                    origin: controller_country.text,
                    category: controller_category.text,
                    ingredients: newstate.ingredientList,
                    instructions: controller_content.text,
                    measures: [], //FIXME -
                    thumbnail: imagestate.selectedImagePath,
                  );
                  context.read<RecipeBloc>().add(AddRecipeEvent(queryRecipe));
                  // BlocProvider.of<RecipeBloc>(context).add(AddRecipeEvent(queryRecipe));
                  toastification.show(
                    context: context,
                    type: ToastificationType.success,
                    style: ToastificationStyle.flatColored,
                    title: 'Component updates available.',
                    description: 'New recipe was successfully added :)',
                    alignment: Alignment.bottomCenter,
                    autoCloseDuration: const Duration(seconds: 4),
                    animationBuilder: (context, animation, alignment, child) => FadeTransition(opacity: animation, child: child),
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: highModeShadow,
                  );
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.check, color: Colors.white, size: 25),
              label: const Text("Submit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
        )
      ],
      actionsAlignment: MainAxisAlignment.end,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ModifyRecipeImageCubit>().removeImage();
    context.read<ModifyIngredientCubit>().clearAllIngredient();
    // BlocProvider.of<ModifyRecipeImageCubit>(context).removeImage();
    // BlocProvider.of<ModifyIngredientCubit>(context).clearAllIngredient();
  }
}
