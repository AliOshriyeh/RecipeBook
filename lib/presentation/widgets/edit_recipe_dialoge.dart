// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/logic/bloc/recipe_bloc.dart';
import 'package:test/data/models/recipe_model.dart';

class EditEventRecipeDialog extends StatefulWidget {
  final Recipe calledRecipe;

  const EditEventRecipeDialog({super.key, required this.calledRecipe});

  @override
  State<EditEventRecipeDialog> createState() => _EditEventRecipeDialogState();
}

class _EditEventRecipeDialogState extends State<EditEventRecipeDialog> {
  late bool isVegan;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller_name = TextEditingController();
  TextEditingController controller_content = TextEditingController();
  TextEditingController controller_calories = TextEditingController();

  @override
  void initState() {
    super.initState();
    isVegan = widget.calledRecipe.isVegan;
    controller_name.text = widget.calledRecipe.name;
    controller_content.text = widget.calledRecipe.content;
    controller_calories.text = widget.calledRecipe.calories;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: const EdgeInsets.all(0),
      icon: Align(alignment: Alignment.topRight, child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded, color: Colors.red))),
      title: const Text("Edit Recipe"),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            controller: controller_name,
            keyboardType: TextInputType.number,
            validator: (value) => (value == null || value.length < 4) ? "Enter A Valid Name" : null,
            decoration: InputDecoration(
                hintText: "Name Your Dish :)",
                contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller_calories,
            validator: (value) => (value == null || int.parse(value) < 300) ? "Amount is Too Low" : null,
            decoration: InputDecoration(
                hintText: "How Much Calories It Has?",
                contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLines: 5,
            maxLength: 300,
            controller: controller_content,
            keyboardType: TextInputType.multiline,
            validator: (value) => (value == null || value.length < 20) ? "Recipe is TOO Short!!" : null,
            decoration: InputDecoration(
                hintText: "Explain How To Make it!",
                contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 8),
          SwitchListTile(title: const Text("Is Vegan"), activeColor: Colors.greenAccent, value: isVegan, onChanged: (bool value) => setState(() => isVegan = value))
        ]),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton.icon(
              style: TextButton.styleFrom(elevation: 5, backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 12)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Recipe queryRecipe = Recipe(id: "${int.parse(widget.calledRecipe.id)}", name: controller_name.text, isVegan: isVegan, content: controller_content.text, calories: controller_calories.text);
                  // widget.callerContext.read<RecipeBloc>().add(EditEventRecipe(queryRecipe));
                  BlocProvider.of<RecipeBloc>(context).add(EditRecipeEvent(queryRecipe));
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.check, color: Colors.white, size: 25),
              label: const Text("Submit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
        )
      ],
      actionsAlignment: MainAxisAlignment.end,
    );
  }
}
