import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/bloc/1Recipe/recipe_bloc.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:test/presentation/widgets/recipe_listTile.dart';

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
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: FloatingActionButton.small(
              heroTag: 'CREATE',
              child: const Icon(Icons.add_rounded),
              onPressed: () => Navigator.of(context).pushReplacementNamed(AppRouter.ROUTE_CREATERECIPE),
              //showDialog(context: context, builder: (BuildContext context) => const CreateRecipeDialog()),
            ),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<RecipeBloc, RecipeState>(builder: (context, recipeState) {
          if (recipeState is RecipeInitial) {
            return const SpinkitCustomLoading(typeNum: 5);
          }
          if (recipeState is RecipeLoaded) {
            return recipeState.recipes.isEmpty
                ? Center(child: Text(AppLocalizations.of(context)!.prmpt_norec))
                : ListView.builder(
                    itemCount: recipeState.recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeListTile(parentContext: context, recipeItem: recipeState.recipes[index], editable: true).display;
                    });
          } else {
            // In Case The App Reads from Outside of Standard States
            return Text(AppLocalizations.of(context)!.prmpt_error);
          }
        }),
      ),
    );
  }
}
