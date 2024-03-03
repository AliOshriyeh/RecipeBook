// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:test/data/models/recipe_model.dart';
import 'package:test/logic/bloc/1Recipe/recipe_bloc.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:test/logic/cubit/3ModifyIngredient/modify_ingredient_cubit.dart';

class ModifyIngredientsScreen extends StatefulWidget {
  final Object? arguments;

  const ModifyIngredientsScreen({super.key, required this.arguments});

  @override
  State<ModifyIngredientsScreen> createState() => _ModifyIngredientsScreenState();
}

class _ModifyIngredientsScreenState extends State<ModifyIngredientsScreen> {
  Recipe get thisRecipe => (widget.arguments! as Map)['RECIPE'];
  String get submitFnc => (widget.arguments! as Map)['SubmitFnc'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("${thisRecipe.name} Recipe")),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.amber.shade800),
              ),
              child: Row(children: [
                Flexible(
                  flex: 2,
                  child: ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      child: Image(
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.2,
                        image: FileImage(File(thisRecipe.thumbnail!)),
                        errorBuilder: (context, error, stackTrace) => CircleAvatar(backgroundColor: Colors.amber[200], child: const Icon(Icons.dinner_dining_rounded, size: 30, color: Colors.grey)),
                      )),
                ),
                const SizedBox(width: 30),
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(children: [const Text("Name: ", style: TextStyle(fontWeight: FontWeight.bold)), Text(thisRecipe.name)]),
                          const SizedBox(height: 15),
                          Row(children: [Text(AppLocalizations.of(context)!.category + ": ", style: const TextStyle(fontWeight: FontWeight.bold)), Text(thisRecipe.category)]),
                          const SizedBox(height: 15),
                          Row(children: [const Text("Country: ", style: TextStyle(fontWeight: FontWeight.bold)), Text(thisRecipe.origin)]),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: thisRecipe.ingredients.length,
                itemBuilder: (context, index) {
                  var ingItem = thisRecipe.ingredients[index];
                  return Card(
                      elevation: 3,
                      shape: ContinuousRectangleBorder(side: const BorderSide(color: Colors.black12, width: 1), borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                          tileColor: Colors.grey.shade100,
                          leading: Chip(label: Text(ingItem)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton.filled(
                                  onPressed: () {
                                    ModifyIngredientCubit modifyIngredientCubit = context.read<ModifyIngredientCubit>();
                                    modifyIngredientCubit.removeIngredient(index);
                                    modifyIngredientCubit.reloadIngredients(null, null);
                                  },
                                  icon: const Icon(Icons.remove_rounded)),
                              BlocBuilder<ModifyIngredientCubit, ModifyIngredientState>(
                                builder: (context, state) {
                                  return Container(
                                    width: 30,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                    child: Text(state.measureList[index].toString()),
                                  );
                                },
                              ),
                              IconButton.filled(
                                  onPressed: () {
                                    ModifyIngredientCubit modifyIngredientCubit = context.read<ModifyIngredientCubit>();
                                    modifyIngredientCubit.addIngredient(index);
                                    modifyIngredientCubit.reloadIngredients(null, null);
                                  },
                                  icon: const Icon(Icons.add_rounded)),
                            ],
                          )));
                },
              ),
            ),
          ],
        ),
      )),
      persistentFooterButtons: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton.icon(
                style: TextButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                onPressed: () {
                  ModifyIngredientState newstate = context.read<ModifyIngredientCubit>().state; //BlocProvider.of<ModifyIngredientCubit>(context).state as ModifyIngredientLoaded;
                  Recipe queryRecipe = Recipe(
                    id: thisRecipe.id,
                    name: thisRecipe.name,
                    origin: thisRecipe.origin,
                    category: thisRecipe.category,
                    measures: newstate.measureList,
                    thumbnail: thisRecipe.thumbnail,
                    ingredients: thisRecipe.ingredients,
                    instructions: thisRecipe.instructions,
                    authorization: false,
                  );
                  //NOTE -  This button is designed to have 2 functions.
                  //1. Create new Recipe when this page is called after CreateRecipeScreen
                  //2. Edit some Recipe when this page is called after EditRecipeScreen
                  // I distinguish between these 2 different functions by <submitFnc> Variable as below
                  switch (submitFnc) {
                    case 'CREATE':
                      context.read<RecipeBloc>().add(AddRecipeEvent(queryRecipe));
                      toastification.show(
                        context: context,
                        type: ToastificationType.success,
                        style: ToastificationStyle.flatColored,
                        title: 'Recipe was Successfully Created',
                        description: 'Recipe ${thisRecipe.name} was added :)',
                        alignment: Alignment.bottomCenter,
                        autoCloseDuration: const Duration(seconds: 5),
                        animationBuilder: (context, animation, alignment, child) => FadeTransition(opacity: animation, child: child),
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: highModeShadow,
                      );
                      break;
                    case 'EDIT':
                      context.read<RecipeBloc>().add(EditRecipeEvent(queryRecipe));
                      toastification.show(
                        context: context,
                        type: ToastificationType.success,
                        style: ToastificationStyle.flatColored,
                        title: 'Recipe was Successfully Edited',
                        description: 'Recipe ${thisRecipe.name} was edited :)',
                        alignment: Alignment.bottomCenter,
                        autoCloseDuration: const Duration(seconds: 5),
                        animationBuilder: (context, animation, alignment, child) => FadeTransition(opacity: animation, child: child),
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: highModeShadow,
                      );
                      break;
                    default:
                  }

                  Navigator.of(context).popAndPushNamed(AppRouter.ROUTE_LOCAL);
                },
                icon: const Icon(Icons.check_rounded, color: Colors.white, size: 25),
                label: Text(submitFnc == 'CREATE' ? "Create" : "Submit", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))))
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context.read<ModifyIngredientCubit>().clearAllIngredient();
  }
}
