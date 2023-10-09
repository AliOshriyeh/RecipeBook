// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/utils/constants/constLists.dart';
import 'package:test/logic/bloc/1Recipe/recipe_bloc.dart';
import 'package:test/logic/cubit/modify_ingredient_cubit.dart';

class CreateRecipeDialog extends StatefulWidget {
  const CreateRecipeDialog({super.key});

  @override
  State<CreateRecipeDialog> createState() => _CreateRecipeDialogState();
}

class _CreateRecipeDialogState extends State<CreateRecipeDialog> {
  bool isVegan = false;
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
        iconPadding: const EdgeInsets.all(0),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        icon: Align(alignment: Alignment.topRight, child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded, color: Colors.red))),
        title: const Text("Create New Recipe"),
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
                  ModifyIngredientCubit ingredientCubit = BlocProvider.of<ModifyIngredientCubit>(context);
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
            const SizedBox(height: 8),
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
                    ModifyIngredientState newstate = BlocProvider.of<ModifyIngredientCubit>(context).state as ModifyIngredientLoaded;
                    Recipe queryRecipe = Recipe(
                      // isVegan: isVegan,
                      name: controller_name.text,
                      origin: controller_country.text,
                      category: controller_category.text,
                      ingredients: newstate.ingredientList,
                      instructions: controller_content.text,
                    );
                    BlocProvider.of<RecipeBloc>(context).add(AddRecipeEvent(queryRecipe));
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.check, color: Colors.white, size: 25),
                label: const Text("Submit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
          )
        ],
        actionsAlignment: MainAxisAlignment.end,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ModifyIngredientCubit>(context).clearAllIngredient();
  }
}
