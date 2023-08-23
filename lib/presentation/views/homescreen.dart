import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/bloc/recipe_bloc.dart';
import 'package:test/presentation/widgets/recipe_listTile.dart';
import 'package:test/presentation/widgets/create_recipe_dialoge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("The Recipe Bloc"),
        backgroundColor: Colors.orange[800],
      ),
      body: Center(child: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is RecipeInitial) {
            return const CircularProgressIndicator(color: Colors.orange);
          }
          if (state is RecipeLoaded) {
            return state.recipes.isEmpty
                ? const Center(child: Text("No Recipes Registered Yet!"))
                : ListView.builder(
                    itemCount: state.recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeListTile(parentContext: context, recipeItem: state.recipes[index]).display;
                    });
          } else {
            // In Case The App Reads from Outside of Standard States
            return const Text("Something Went Wrong!");
          }
        },
      )),

      //Add New Recipes
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange[800],
          onPressed: () {
            RecipeState lateState = context.read<RecipeBloc>().state;
            showDialog(context: context, builder: (BuildContext context) => CreateRecipeDialog(lastID: lateState.recipes.isNotEmpty ? lateState.recipes.last.id : "-1"));
          },
          child: const Icon(Icons.add_rounded)),
    );
  }
}
