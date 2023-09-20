// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/presentation/widgets/delete_recipe_dialog.dart';
import 'package:test/presentation/widgets/edit_recipe_dialoge.dart';

class RecipeListTile extends Equatable {
  final BuildContext parentContext; //TODO - Gotta remove this field somehow
  final Recipe recipeItem;

  const RecipeListTile({required this.parentContext, required this.recipeItem});

  Widget get display => Container(
        padding: const EdgeInsets.all(5),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(20)),
          title: Text(recipeItem.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black)),
          leading: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(10),
            child: Image.network(
              recipeItem.thumbnail ?? "NULL",
              errorBuilder: (context, error, stackTrace) => CircleAvatar(backgroundColor: Colors.amber[200], child: const Icon(Icons.local_dining_rounded, size: 30, color: Colors.grey)),
            ),
          ),
          // recipeItem.isVegan ? const Icon(Icons.emoji_emotions_rounded, size: 30, color: Colors.green): const Icon(Icons.outlet_rounded, size: 30, color: Colors.red)
          childrenPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          subtitle: Text("Category: ${recipeItem.category}", style: const TextStyle(fontSize: 16)),
          children: [
            Text(recipeItem.instructions, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
            const SizedBox(height: 5),
          ],
        ),
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
