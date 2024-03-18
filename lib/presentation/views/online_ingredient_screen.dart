// ignore_for_file: prefer_final_fields, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/data/models/Ingredient_model.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/presentation/widgets/ingredient_listTile.dart';
import 'package:test/logic/bloc/2OnlineCookBook/online_cookbook_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:test/presentation/widgets/spinkit_loading.dart';

class OnlineIngredientScreen extends StatefulWidget {
  const OnlineIngredientScreen({super.key});

  @override
  State<OnlineIngredientScreen> createState() => _OnlineIngredientScreenState();
}

class _OnlineIngredientScreenState extends State<OnlineIngredientScreen> {
  @override
  void initState() {
    super.initState();
    OnlineCookBookBloc onlineCookbookBloc = context.read<OnlineCookBookBloc>();
    onlineCookbookBloc.add(LoadOnlineIngredientEvent(Recipe.nullRecipe, Ingredient.nullIngredient));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.apptitle)),
      body: Center(
        child: BlocBuilder<OnlineCookBookBloc, OnlineCookBookState>(builder: (context, state) {
          if (state is OnlineCookBookIdle || (state is OnlineCookBookLoaded && state.ingredients.isEmpty)) {
            // In Case The App Reads from Outside of Standard States
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.prmpt_noingredient + '\n' + AppLocalizations.of(context)!.prmpt_frstIngredient, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                const SpinkitCustomLoading(typeNum: 5),
              ],
            );
          } else if (state is OnlineCookBookLoaded && state.ingredients.isNotEmpty) {
            return ListView.builder(
                itemCount: state.ingredients.length,
                itemBuilder: (context, index) {
                  return IngredientListTile(parentContext: context, ingredientItem: state.ingredients[index], editable: false).display;
                });
          } else {
            // In Case The App Reads from Outside of Standard States
            return Text(AppLocalizations.of(context)!.prmpt_error);
          }
        }),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    //When switching between Recipe and Ingredient Page. There a problem shows itself.
    //Since the Bloc State has both List<Recipe> and List<Ingredient> as Property and I designed it to show the relative one for its page.
    //Meaning List<Recipe> for RecipeScreen and List<Ingredient> for IngredientScreen, And giving the other property as Empty each time around.
    //When You go into One of them (Let's Say RecipeScreen) first and then go to the other (IngredientScreen) since we gave Empty List to The state in the last Event. It shows empty at first and then gets fixed in initState()
    //The Solution I came with is to Reset the Cookbook Bloc State when each page is exited and recall the event with initState().
    //Hence I Use the didChangeDependencies since Dispose method creates problems with Ancester Tree
    context.read<OnlineCookBookBloc>().add(ResetOnlineCookBookEvent(Recipe.nullRecipe, Ingredient.nullIngredient));
    super.didChangeDependencies();
  }
}
