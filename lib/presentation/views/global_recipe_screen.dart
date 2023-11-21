// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/presentation/widgets/recipe_listTile.dart';
import 'package:test/logic/bloc/2OnlineRecipe/online_recipe_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';

class GlobalRecipeScreen extends StatefulWidget {
  const GlobalRecipeScreen({super.key});

  @override
  State<GlobalRecipeScreen> createState() => _GlobalRecipeScreenState();
}

class _GlobalRecipeScreenState extends State<GlobalRecipeScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    OnlineRecipeBloc recipeOnlineBloc = context.read<OnlineRecipeBloc>();
    recipeOnlineBloc.add(LoadOnlineRecipeEvent(Recipe.nullRecipe));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.apptitle),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add_rounded),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: Center(
        child: BlocBuilder<OnlineRecipeBloc, OnlineRecipeState>(builder: (context, recipeState) {
          if (recipeState is OnlineRecipeInitial) {
            return const CircularProgressIndicator(color: Colors.red);
          }
          if (recipeState is OnlineRecipeLoaded) {
            return recipeState.recipes.isEmpty
                ? const Center(child: Text("No Recipes Registered Yet!"))
                : ListView.builder(
                    itemCount: recipeState.recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeListTile(parentContext: context, recipeItem: recipeState.recipes[index], editable: false).display;
                    });
          } else {
            // In Case The App Reads from Outside of Standard States
            return const Text("Something Went Wrong!");
          }
        }),
      ),

      //Add New Recipes
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => showDialog(context: context, builder: (BuildContext context) => const CreateRecipeDialog()),
      //   child: const Icon(Icons.add_rounded),
      // ),
    );
  }

  @override
  void dispose() => super.dispose();
}
