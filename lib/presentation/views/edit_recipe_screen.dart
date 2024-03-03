// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:test/data/models/recipe_model.dart';
import 'package:test/utils/constants/constLists.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:test/logic/cubit/3ModifyIngredient/modify_ingredient_cubit.dart';
import 'package:test/logic/cubit/5ModifyRecipeImage/modify_ingredient_image_cubit.dart';

class EditRecipeScreen extends StatefulWidget {
  final Object? arguments;

  const EditRecipeScreen({super.key, required this.arguments});

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  Recipe get thisRecipe => (widget.arguments! as Map)['RECIPE'];

  final _formKey = GlobalKey<FormState>();
  TextEditingController controller_name = TextEditingController();
  TextEditingController controller_content = TextEditingController();
  TextEditingController controller_country = TextEditingController();
  TextEditingController controller_category = TextEditingController();
  TextEditingController controller_ingredient = TextEditingController();

  List<String> categoryEntries = categoryMap.entries.map((element) => element.key).toList();

  @override
  void initState() {
    super.initState();
    controller_name.text = thisRecipe.name;
    controller_country.text = thisRecipe.origin;
    controller_content.text = thisRecipe.instructions;
    controller_category.text = thisRecipe.category.toString();
    controller_ingredient.text = thisRecipe.ingredients.join('|');
  }

  @override
  Widget build(BuildContext context) {
    ModifyRecipeImageCubit recipeImageCubit = context.read<ModifyRecipeImageCubit>();
    recipeImageCubit.loadImagePath(thisRecipe.thumbnail); //Recalling Recipe's Image
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(controller_name.text)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: [
            BlocBuilder<ModifyRecipeImageCubit, ModifyRecipeImageState>(
              builder: (context, imageState) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.small(heroTag: 'CAMERA', onPressed: () => recipeImageCubit.addRecipeImageFromCamera(), child: const Icon(Icons.camera_alt_rounded)),
                    recipeImageCubit.state.selectedImagePath == 'NULL'
                        ? Container(
                            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFBDE92), Color(0xFFF8B502)]), shape: BoxShape.circle),
                            child: const CircleAvatar(
                              maxRadius: 70,
                              backgroundColor: Colors.transparent,
                              child: Icon(Icons.dinner_dining_rounded, size: 85, color: Colors.white60),
                            ),
                          )
                        : CircleAvatar(maxRadius: 70, foregroundImage: FileImage(File(imageState.selectedImagePath))),
                    FloatingActionButton.small(heroTag: 'GALLARY', onPressed: () => recipeImageCubit.addRecipeImageFromGallary(), child: const Icon(Icons.image_search_rounded)),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                //Assign Name
                TextFormField(
                  controller: controller_name,
                  validator: (value) => (value == null || value.length < 4) ? AppLocalizations.of(context)!.ent_valname : null,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.ent_recname,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(height: 8),
                //Assign Category
                DropdownSearch<String>(
                  items: categoryEntries,
                  selectedItem: controller_category.text,
                  validator: (value) => (value == null || value.isEmpty) ? AppLocalizations.of(context)!.chs_category : null,
                  onChanged: (selectedCategory) => controller_category.text = selectedCategory ?? "",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: PopupProps.modalBottomSheet(
                      loadingBuilder: (context, searchEntry) => const Center(child: CircularProgressIndicator()),
                      listViewProps: const ListViewProps(padding: EdgeInsets.symmetric(horizontal: 10)),
                      modalBottomSheetProps: const ModalBottomSheetProps(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ))),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.category,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                //Assign Country
                DropdownSearch<String>(
                  items: countryList,
                  selectedItem: controller_country.text,
                  validator: (value) => (value == null || value.isEmpty) ? AppLocalizations.of(context)!.chs_country : null,
                  onChanged: (selectedCountry) => controller_country.text = selectedCountry ?? "",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  popupProps: PopupProps.modalBottomSheet(
                      showSearchBox: true,
                      loadingBuilder: (context, searchEntry) => const Center(child: CircularProgressIndicator()),
                      emptyBuilder: (context, searchEntry) => Center(child: Text(AppLocalizations.of(context)!.prmpt_search(searchEntry))),
                      //FIXME - Create a better error message
                      errorBuilder: (context, searchEntry, exception) => const Center(child: Icon(Icons.error_rounded, color: Colors.grey, size: 200)),
                      searchFieldProps: TextFieldProps(
                        controller: controller_country,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: () => controller_country.clear(), icon: const Icon(Icons.clear_rounded)),
                            hintText: AppLocalizations.of(context)!.ent_country,
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(20.0))),
                      ),
                      listViewProps: const ListViewProps(padding: EdgeInsets.symmetric(horizontal: 10)),
                      modalBottomSheetProps: const ModalBottomSheetProps(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ))),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.origin,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)), //Because when DropdownMenu is clicked, "Origin" shows ⁡⁢⁣⁢unacceptable⁡ behaviour
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0))),
                  ),
                  filterFn: (user, filter) => user.toUpperCase().contains(filter.toUpperCase()),
                ),
                const SizedBox(height: 8),
                DropdownSearch<String>.multiSelection(
                  asyncItems: (String filter) async {
                    List<dynamic> query = await Supabase.instance.client.from('Ingredients').select("ingName");
                    List<String> result = [];
                    // ignore: avoid_function_literals_in_foreach_calls
                    query.forEach((element) => result.add(element["ingName"]));
                    return result;
                  },
                  validator: (value) => (value == null || value.isEmpty) ? "Add Ingredients" : null,
                  onChanged: (selectedIngredientsList) {
                    ModifyIngredientCubit ingredientCubit = context.read<ModifyIngredientCubit>();
                    List<int> selectedMeasuresList = List.filled(selectedIngredientsList.length, 1);
                    ingredientCubit.reloadIngredients(selectedIngredientsList, selectedMeasuresList);
                  },
                  popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      showSearchBox: true,
                      loadingBuilder: (context, searchEntry) => const Center(child: CircularProgressIndicator()),
                      emptyBuilder: (context, searchEntry) => Center(child: Text(AppLocalizations.of(context)!.prmpt_search(searchEntry))),
                      //FIXME - Create a better error message
                      errorBuilder: (context, searchEntry, exception) => const Center(child: Icon(Icons.error_rounded, color: Colors.grey, size: 200)),
                      searchFieldProps: TextFieldProps(
                        controller: controller_ingredient,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: () => controller_ingredient.clear(), icon: const Icon(Icons.clear_rounded)),
                            hintText: AppLocalizations.of(context)!.ent_Ingredient,
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(20.0))),
                      ),
                      listViewProps: const ListViewProps(padding: EdgeInsets.symmetric(horizontal: 10)),
                      modalBottomSheetProps: const ModalBottomSheetProps(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ))),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.ingredients,
                        hintText: AppLocalizations.of(context)!.ent_valIngredient,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)), //Because when DropdownMenu is clicked, "Origin" shows ⁡⁢⁣⁢unacceptable⁡ behaviour
                        // focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0))),
                  ),
                  selectedItems: controller_ingredient.text.split('|'),
                  filterFn: (user, filter) => user.toUpperCase().contains(filter.toUpperCase()),
                ),

                const SizedBox(height: 8),
                TextFormField(
                  maxLines: 5,
                  maxLength: 300,
                  controller: controller_content,
                  keyboardType: TextInputType.multiline,
                  validator: (value) => (value == null || value.length < 20) ? AppLocalizations.of(context)!.ent_valdesc : null,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.ent_recdesc,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
                ),
              ]),
            ),
          ]),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton.icon(
              style: TextButton.styleFrom(elevation: 5, backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 12)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ModifyIngredientState newstate = context.read<ModifyIngredientCubit>().state; //BlocProvider.of<ModifyIngredientCubit>(context).state as ModifyIngredientLoaded;
                  ModifyRecipeImageState imagestate = context.read<ModifyRecipeImageCubit>().state; // BlocProvider.of<ModifyRecipeImageCubit>(context).state;
                  Recipe queryRecipe = Recipe(
                    id: thisRecipe.id,
                    name: controller_name.text,
                    origin: controller_country.text,
                    category: controller_category.text,
                    ingredients: newstate.ingredientList,
                    instructions: controller_content.text,
                    measures: newstate.measureList,
                    thumbnail: imagestate.selectedImagePath,
                    authorization: false,
                  );
                  // context.read<RecipeBloc>().add(AddRecipeEvent(queryRecipe));
                  // toastification.show(
                  //   context: context,
                  //   type: ToastificationType.success,
                  //   style: ToastificationStyle.flatColored,
                  //   title: 'Component updates available.',
                  //   description: 'New recipe was successfully added :)',
                  //   alignment: Alignment.bottomCenter,
                  //   autoCloseDuration: const Duration(seconds: 4),
                  //   animationBuilder: (context, animation, alignment, child) => FadeTransition(opacity: animation, child: child),
                  //   borderRadius: BorderRadius.circular(100.0),
                  //   boxShadow: highModeShadow,
                  // );
                  Navigator.of(context).pushReplacementNamed(AppRouter.ROUTE_MINGREDIENT, arguments: {'RECIPE': queryRecipe, 'SubmitFnc': 'EDIT'});
                }
              },
              icon: const Icon(Icons.navigate_next_rounded, color: Colors.white, size: 25),
              label: Text(AppLocalizations.of(context)!.next, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies;
    context.read<ModifyRecipeImageCubit>().removeImage();
    // context.read<ModifyIngredientCubit>().clearAllIngredient();
    // BlocProvider.of<ModifyRecipeImageCubit>(context).removeImage();
    // BlocProvider.of<ModifyIngredientCubit>(context).clearAllIngredient();
  }
}
