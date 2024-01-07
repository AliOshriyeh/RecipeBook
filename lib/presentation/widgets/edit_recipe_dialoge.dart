// // ignore_for_file: non_constant_identifier_names

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:test/logic/cubit/5ModifyRecipeImage/modify_ingredient_image_cubit.dart';
// import 'package:toastification/toastification.dart';
// import 'package:test/data/models/recipe_model.dart';
// import 'package:test/utils/constants/constLists.dart';
// import 'package:test/logic/bloc/1Recipe/recipe_bloc.dart';
// import 'package:test/logic/cubit/3ModifyIngredient/modify_ingredient_cubit.dart';

// class EditEventRecipeDialog extends StatefulWidget {
//   final Recipe calledRecipe;

//   const EditEventRecipeDialog({super.key, required this.calledRecipe});

//   @override
//   State<EditEventRecipeDialog> createState() => _EditEventRecipeDialogState();
// }

// class _EditEventRecipeDialogState extends State<EditEventRecipeDialog> {
//   // late bool isVegan;
//   String? selectedImagePath;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController controller_name = TextEditingController();
//   TextEditingController controller_content = TextEditingController();
//   TextEditingController controller_country = TextEditingController();
//   TextEditingController controller_category = TextEditingController();
//   TextEditingController controller_ingredient = TextEditingController();

//   List<DropdownMenuEntry> countryEntries = countryList.map((element) => DropdownMenuEntry(value: element, label: element)).toList();
//   List<DropdownMenuEntry> categoryEntries = categoryMap.entries.map((element) => DropdownMenuEntry(value: element.value.name, label: element.value.name)).toList();
//   @override
//   void initState() {
//     super.initState();
//     // isVegan = widget.calledRecipe.isVegan;
//     controller_name.text = widget.calledRecipe.name;
//     controller_country.text = widget.calledRecipe.origin;
//     controller_content.text = widget.calledRecipe.instructions;
//     selectedImagePath = widget.calledRecipe.thumbnail;
//     controller_category.text = widget.calledRecipe.category.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //NOTE - Should I Remove Blocprovider from build?
//     ModifyRecipeImageCubit recipeImageCubit = context.read<ModifyRecipeImageCubit>();
//     recipeImageCubit.loadImagePath(widget.calledRecipe.thumbnail); //Recalling Recipe's Image
//     ModifyIngredientCubit ingredientCubit = context.read<ModifyIngredientCubit>();
//     ingredientCubit.refreshIngredient(widget.calledRecipe.ingredients); //Recalling Old Ingredients| ⁡⁢⁣⁢Supe⁡⁢⁣⁢r ⁡⁢⁣⁢𝗜𝗠𝗣𝗢𝗥𝗧𝗔𝗡𝗧⁡ When Calling ModifyIngredientCubit⁡

//     return SingleChildScrollView(
//       child: AlertDialog(
//         iconPadding: const EdgeInsets.all(0),
//         icon: Align(alignment: Alignment.topRight, child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded, color: Colors.red))),
//         title: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: BlocBuilder<ModifyRecipeImageCubit, ModifyRecipeImageState>(
//             builder: (context, imageState) {
//               return Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FloatingActionButton.small(heroTag: 'CAMERA', onPressed: () => recipeImageCubit.addRecipeImageFromCamera(), child: const Icon(Icons.camera_alt_rounded)),
//                   imageState.selectedImagePath == 'NULL'
//                       ? CircleAvatar(
//                           maxRadius: 70,
//                           backgroundColor: Colors.amber.shade400,
//                           child: const Icon(Icons.dinner_dining_rounded, size: 85, color: Colors.white60),
//                         )
//                       : CircleAvatar(maxRadius: 70, foregroundImage: FileImage(File(imageState.selectedImagePath))),
//                   FloatingActionButton.small(heroTag: 'GALLARY', onPressed: () => recipeImageCubit.addRecipeImageFromGallary(), child: const Icon(Icons.image_search_rounded)),
//                 ],
//               );
//             },
//           ),
//         ),
//         content: Form(
//           key: _formKey,
//           child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
//             TextFormField(
//               controller: controller_name,
//               keyboardType: TextInputType.number,
//               validator: (value) => (value == null || value.length < 4) ? "Enter A Valid Name" : null,
//               decoration: InputDecoration(
//                   hintText: "Name Your Dish :)",
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
//                   focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
//             ),
//             const SizedBox(height: 8),
//             DropdownMenu(
//                 dropdownMenuEntries: categoryEntries,
//                 controller: controller_category,
//                 hintText: "Assign Category",
//                 inputDecorationTheme: InputDecorationTheme(
//                     enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0),
//                 ))),
//             const SizedBox(height: 8),
//             DropdownMenu(
//                 dropdownMenuEntries: countryEntries,
//                 controller: controller_country,
//                 hintText: "Assign Origin",
//                 inputDecorationTheme: InputDecorationTheme(
//                     enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0),
//                 ))),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: controller_ingredient,
//               onTap: () => controller_ingredient.clear(),
//               keyboardType: TextInputType.text,
//               // validator: (value) => (value == null || value.length < 3) ? "Enter A Valid Ingredient" : null,
//               onFieldSubmitted: (newValue) async {
//                 if (newValue.length > 2) {
//                   ingredientCubit.addIngredient(newValue);
//                   ingredientCubit.refreshIngredient(null);
//                   controller_ingredient.clear();
//                 } else {
//                   controller_ingredient.text = "Enter A Valid Ingredient";
//                 }
//               },
//               decoration: InputDecoration(
//                   hintText: "Add Ingredients",
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
//                   focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
//             ),
//             const SizedBox(height: 8),
//             BlocBuilder<ModifyIngredientCubit, ModifyIngredientState>(
//               builder: (context, ingredientstate) {
//                 List<Widget> ingredientEntry = ingredientstate.ingredientList
//                     .where((element) => element.isNotEmpty)
//                     .map((element) => Chip(
//                           label: Text(element),
//                           onDeleted: () {
//                             ingredientCubit.removeIngredient(element);
//                             ingredientCubit.refreshIngredient(null);
//                           },
//                           deleteIcon: const Icon(Icons.cancel_rounded),
//                         ))
//                     .toList();
//                 return Wrap(spacing: 5, children: ingredientEntry);
//               },
//             ),
//             TextFormField(
//               maxLines: 5,
//               maxLength: 300,
//               controller: controller_content,
//               keyboardType: TextInputType.multiline,
//               validator: (value) => (value == null || value.length < 20) ? "Recipe is TOO Short!!" : null,
//               decoration: InputDecoration(
//                   hintText: "Explain How To Make it!",
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
//                   focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
//             ),
//             const SizedBox(height: 8),
//             // SwitchListTile(title: const Text("Is Vegan"), activeColor: Colors.greenAccent, value: isVegan, onChanged: (bool value) => setState(() => isVegan = value))
//           ]),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: TextButton.icon(
//                 style: TextButton.styleFrom(elevation: 5, backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 12)),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     ModifyIngredientState newstate = ingredientCubit.state as ModifyIngredientLoaded;
//                     ModifyRecipeImageState imagestate = context.read<ModifyRecipeImageCubit>().state;
//                     Recipe queryRecipe = Recipe(
//                       //isVegan: isVegan,
//                       id: widget.calledRecipe.id,
//                       name: controller_name.text,
//                       origin: controller_country.text,
//                       category: controller_category.text,
//                       ingredients: newstate.ingredientList,
//                       measures: [], //FIXME -
//                       instructions: controller_content.text,
//                       thumbnail: imagestate.selectedImagePath,
//                     );
//                     // final exampleCubit = context.read<ExampleCubit>(); // Get the cubit(bloc) instance
//                     // widget.callerContext.read<RecipeBloc>().add(EditEventRecipe(queryRecipe));
//                     context.read<RecipeBloc>().add(EditRecipeEvent(queryRecipe));
//                     // BlocProvider.of<RecipeBloc>(context).add(EditRecipeEvent(queryRecipe));
//                     toastification.show(
//                       context: context,
//                       boxShadow: highModeShadow,
//                       type: ToastificationType.success,
//                       alignment: Alignment.bottomCenter,
//                       style: ToastificationStyle.flatColored,
//                       borderRadius: BorderRadius.circular(100.0),
//                       title: '${controller_name.text.toUpperCase()} Recipe Edited',
//                       description: 'The recipe #${widget.calledRecipe.id} was successfully modified.',
//                       autoCloseDuration: const Duration(seconds: 4),
//                       animationBuilder: (context, animation, alignment, child) => FadeTransition(opacity: animation, child: child),
//                     );
//                     Navigator.pop(context);
//                   }
//                 },
//                 icon: const Icon(Icons.check, color: Colors.white, size: 25),
//                 label: const Text("Submit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
//           )
//         ],
//         actionsAlignment: MainAxisAlignment.end,
//       ),
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     context.read<ModifyRecipeImageCubit>().removeImage();
//     context.read<ModifyIngredientCubit>().clearAllIngredient();
//     // BlocProvider.of<ModifyRecipeImageCubit>(context).removeImage();
//     // BlocProvider.of<ModifyIngredientCubit>(context).clearAllIngredient();
//   }
// }
