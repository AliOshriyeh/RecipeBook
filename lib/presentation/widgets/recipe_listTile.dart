// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:test/logic/cubit/3ModifyIngredient/modify_ingredient_cubit.dart';
import 'package:test/presentation/widgets/edit_recipe_dialoge.dart';
import 'package:test/presentation/widgets/delete_recipe_dialog.dart';
import 'package:test/presentation/widgets/spinkit_loading.dart';

class RecipeListTile extends Equatable {
  final BuildContext parentContext; //TODO - Gotta remove this field somehow
  final Recipe recipeItem;
  final bool editable;

  const RecipeListTile({required this.parentContext, required this.recipeItem, required this.editable});

  bool get isThumbnailURL => recipeItem.thumbnail != null && Uri.parse(recipeItem.thumbnail!).isAbsolute ? true : false;

  Widget get display => Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(20)),
          title: Text(recipeItem.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black)),
          leading: FullScreenWidget(
            disposeLevel: DisposeLevel.Low,
            child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(10),
                child: Image(
                  image: (isThumbnailURL ? NetworkImage(recipeItem.thumbnail ?? "NULL") : FileImage(File(recipeItem.thumbnail!)) as ImageProvider),
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(parentContext).size.width * 0.2,
                  errorBuilder: (context, error, stackTrace) => CircleAvatar(backgroundColor: Colors.amber[200], child: const Icon(Icons.local_dining_rounded, size: 30, color: Colors.grey)),
                )),
          ),
          // recipeItem.isVegan ? const Icon(Icons.emoji_emotions_rounded, size: 30, color: Colors.green): const Icon(Icons.outlet_rounded, size: 30, color: Colors.red)
          childrenPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          subtitle: Text("Category: ${recipeItem.category}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
          children: [
            Text(recipeItem.instructions, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Align(alignment: Alignment.centerLeft, child: Text('${AppLocalizations.of(parentContext)!.ingredients}:', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
            const SizedBox(height: 5),
            // TODO - Here I have a bug that when I change Ingredients of an recipe
            // Its content changes, databases but the reload won't happen.
            // Mainly because the item is the same with a minor change which ⁡⁢⁣⁢won't show up⁡ in blockbuilder's radar
            // So I decided to plant this blocbuilder to observe and act when the list changes.⁡⁢⁣⁢ Open for new IDEAS!⁡
            BlocBuilder<ModifyIngredientCubit, ModifyIngredientState>(
              builder: (context, state) {
                if (state is IngredientAdded || state is IngredientRemoved) {
                  return const SpinkitCustomLoading(typeNum: 5);
                } else if (state is ModifyIngredientInitial || state is ModifyIngredientLoaded) {
                  return Wrap(spacing: 8, children: recipeItem.ingredients.where((element) => element.isNotEmpty).map((element) => Chip(label: Text(element))).toList());
                } else {
                  // In Case The App Reads from Outside of Standard States
                  return const Text("Something Went Wrong!");
                }
              },
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: editable,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                FloatingActionButton(
                    mini: true,
                    onPressed: () async {
                      await showDialog(context: parentContext, builder: (BuildContext context) => EditEventRecipeDialog(calledRecipe: recipeItem));
                    },
                    backgroundColor: Colors.amber,
                    child: const Icon(Icons.edit_rounded, color: Colors.white)),
                FloatingActionButton(
                    mini: true,
                    onPressed: () async {
                      await showDialog(context: parentContext, builder: (BuildContext context) => DeleteRecipeDialog(calledRecipe: recipeItem));
                    },
                    backgroundColor: Colors.orange[900],
                    child: const Icon(Icons.delete_rounded, color: Colors.white)),
              ]),
            ),
            const SizedBox(height: 5),
          ],
        ),
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
