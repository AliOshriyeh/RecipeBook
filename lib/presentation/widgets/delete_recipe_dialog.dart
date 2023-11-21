import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:test/data/models/recipe_model.dart';
import 'package:test/logic/bloc/1Recipe/recipe_bloc.dart';

class DeleteRecipeDialog extends StatelessWidget {
  final Recipe calledRecipe;

  const DeleteRecipeDialog({super.key, required this.calledRecipe});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: const EdgeInsets.all(0),
      icon: Align(alignment: Alignment.topRight, child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded, color: Colors.red))),
      title: Icon(Icons.delete_forever_rounded, color: Colors.grey[400], size: 200),
      actionsAlignment: MainAxisAlignment.center,
      content: const Text("Are You Sure You Want To Delete This Recipe?", textAlign: TextAlign.center),
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      actions: [
        TextButton.icon(
            style: TextButton.styleFrom(elevation: 5, backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(horizontal: 12)),
            onPressed: () {
              context.read<RecipeBloc>().add(RemoveRecipeEvent(calledRecipe));
              // callerContext.read<RecipeBloc>().add(RemoveRecipeEvent(calledRecipe));
              // BlocProvider.of<RecipeBloc>(context).add(RemoveRecipeEvent(calledRecipe));
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.flatColored,
                title: '${calledRecipe.name.toUpperCase()} Recipe Deleted',
                description: 'The recipe #${calledRecipe.id} was successfully removed.',
                alignment: Alignment.bottomCenter,
                autoCloseDuration: const Duration(seconds: 4),
                animationBuilder: (context, animation, alignment, child) => FadeTransition(opacity: animation, child: child),
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: highModeShadow,
              );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check, color: Colors.white, size: 20),
            label: const Text("Delete", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
        TextButton.icon(
            style: TextButton.styleFrom(elevation: 5, backgroundColor: Colors.white, side: const BorderSide(width: 1, color: Colors.grey), padding: const EdgeInsets.symmetric(horizontal: 12)),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.cancel, color: Colors.grey, size: 20),
            label: const Text("Abort", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
      ],
    );
  }
}
