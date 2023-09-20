import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/bloc/2OnlineRecipe/online_recipe_bloc.dart';
import 'package:test/presentation/widgets/recipe_listTile.dart';
import 'package:test/presentation/widgets/create_recipe_dialoge.dart';

class GlobalRecipeScreen extends StatefulWidget {
  const GlobalRecipeScreen({super.key});

  @override
  State<GlobalRecipeScreen> createState() => _GlobalRecipeScreenState();
}

class _GlobalRecipeScreenState extends State<GlobalRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("The Recipe Bloc"),
        backgroundColor: Colors.orange[800],
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
