import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/bloc/1Recipe/recipe_bloc.dart';
import 'package:test/presentation/widgets/recipe_listTile.dart';
import 'package:test/presentation/widgets/create_recipe_dialoge.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:test/presentation/widgets/spinkit_loading.dart';

class LocalRecipeScreen extends StatefulWidget {
  const LocalRecipeScreen({super.key});

  @override
  State<LocalRecipeScreen> createState() => _LocalRecipeScreenState();
}

class _LocalRecipeScreenState extends State<LocalRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.apptitle),
        backgroundColor: Colors.orange[800],
      ),
      body: Center(
        child: BlocBuilder<RecipeBloc, RecipeState>(builder: (context, recipeState) {
          if (recipeState is RecipeInitial) {
            return const SpinkitCustomLoading(typeNum: 5);
          }
          if (recipeState is RecipeLoaded) {
            return recipeState.recipes.isEmpty
                ? const Center(child: Text("No Recipes Registered Yet!"))
                : ListView.builder(
                    itemCount: recipeState.recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeListTile(parentContext: context, recipeItem: recipeState.recipes[index]).display;
                    });
          } else {
            // In Case The App Reads from Outside of Standard States
            return const Text("Something Went Wrong!");
          }
        }),
      ),

      //Add New Recipes
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[800],
        onPressed: () => showDialog(context: context, builder: (BuildContext context) => const CreateRecipeDialog()),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
