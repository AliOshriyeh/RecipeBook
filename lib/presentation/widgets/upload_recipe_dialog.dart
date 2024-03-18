import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:test/data/models/recipe_model.dart';
import 'package:test/data/models/Ingredient_model.dart';
import 'package:test/logic/bloc/2OnlineCookBook/online_cookbook_bloc.dart';

class UploadRecipeDialog extends StatelessWidget {
  final Recipe calledRecipe;

  const UploadRecipeDialog({super.key, required this.calledRecipe});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: const EdgeInsets.all(0),
      icon: Align(alignment: Alignment.topRight, child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded, color: Colors.red))),
      title: Icon(Icons.cloud_upload_rounded, color: Colors.grey[400], size: 200),
      actionsAlignment: MainAxisAlignment.center,
      content: Text(AppLocalizations.of(context)!.prmpt_recupload, textAlign: TextAlign.center),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      actions: [
        TextButton.icon(
            style: TextButton.styleFrom(elevation: 5, backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 12)),
            onPressed: () {
              context.read<OnlineCookBookBloc>().add(AddOnlineCookBookEvent(calledRecipe, Ingredient.nullIngredient));
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.flatColored,
                title: '${calledRecipe.name.toUpperCase()} Recipe Uploaded',
                description: 'Check in your <Online Recipes> After ADMIN confirmation. ',
                alignment: Alignment.bottomCenter,
                autoCloseDuration: const Duration(seconds: 5),
                animationBuilder: (context, animation, alignment, child) => FadeTransition(opacity: animation, child: child),
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: highModeShadow,
              );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check, color: Colors.white, size: 20),
            label: Text(AppLocalizations.of(context)!.upload, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
        TextButton.icon(
            style: TextButton.styleFrom(elevation: 5, backgroundColor: Colors.white, side: const BorderSide(width: 1, color: Colors.grey), padding: const EdgeInsets.symmetric(horizontal: 12)),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.cancel, color: Colors.grey, size: 20),
            label: Text(AppLocalizations.of(context)!.abort, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
      ],
    );
  }
}
