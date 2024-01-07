// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:test/data/models/Ingredient_model.dart';
import 'package:test/presentation/widgets/table_info_cell.dart';

class IngredientListTile extends Equatable {
  final BuildContext parentContext; //TODO - Gotta remove this field somehow
  final Ingredient ingredientItem;
  final bool editable;

  const IngredientListTile({required this.parentContext, required this.ingredientItem, required this.editable});

  bool get isThumbnailURL => ingredientItem.thumbnail != null && Uri.parse(ingredientItem.thumbnail!).isAbsolute ? true : false;

  Widget get display => Card(
        elevation: 3,
        shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          title: Text(ingredientItem.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black)),
          leading: FullScreenWidget(
            disposeLevel: DisposeLevel.Low,
            child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(10),
                child: Image(
                  //Since I Made sure that if url is null it's replced by 'NULL' There is no chance URL is null here
                  image: (isThumbnailURL ? NetworkImage(ingredientItem.thumbnail!) : FileImage(File(ingredientItem.thumbnail!)) as ImageProvider),
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(parentContext).size.width * 0.2,
                  errorBuilder: (context, error, stackTrace) => CircleAvatar(backgroundColor: Colors.amber[200], child: const Icon(Icons.dinner_dining_rounded, size: 30, color: Colors.grey)),
                )),
          ),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
          subtitle: Text("Calories: ${ingredientItem.calories}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
          children: [
            Align(alignment: Alignment.centerLeft, child: Text("Amount: ${ingredientItem.amount}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
            const SizedBox(height: 5),
            const Align(alignment: Alignment.centerLeft, child: Text("Nutrition Facts:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
            const SizedBox(height: 5),
            Table(
              border: TableBorder.all(borderRadius: BorderRadius.circular(5)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableInfoCell("Total Fat", ingredientItem.totalFat).display,
                if (ingredientItem.satFat != '0 g') TableInfoCell("${"─" * 2} Saturated Fat", ingredientItem.satFat).display,
                if (ingredientItem.transFat != '0 g') TableInfoCell("${"─" * 2} Trans Fat", ingredientItem.transFat).display,
                TableInfoCell("Cholesterol", ingredientItem.cholesterol).display,
                TableInfoCell("Total Carbohydrate", ingredientItem.totalCarb).display,
                TableInfoCell("${"─" * 2} Dietary Fiber", ingredientItem.dietaryFiber).display,
                if (ingredientItem.sugar != '0 g') TableInfoCell("${"─" * 2} Granulated Sugar", ingredientItem.sugar).display,
                if (ingredientItem.protein != '0 g') TableInfoCell("Protein", ingredientItem.protein).display,
                if (ingredientItem.vitamins.vitA != '0 g') TableInfoCell("Vitamin A", ingredientItem.vitamins.vitA).display,
                if (ingredientItem.vitamins.vitB1 != '0 g') TableInfoCell("Vitamin B1", ingredientItem.vitamins.vitB1).display,
                if (ingredientItem.vitamins.vitB2 != '0 g') TableInfoCell("Vitamin B2", ingredientItem.vitamins.vitB2).display,
                if (ingredientItem.vitamins.vitB3 != '0 g') TableInfoCell("Vitamin B3", ingredientItem.vitamins.vitB3).display,
                if (ingredientItem.vitamins.vitB5 != '0 g') TableInfoCell("Vitamin B5", ingredientItem.vitamins.vitB5).display,
                if (ingredientItem.vitamins.vitB6 != '0 g') TableInfoCell("Vitamin B6", ingredientItem.vitamins.vitB6).display,
                if (ingredientItem.vitamins.vitB7 != '0 g') TableInfoCell("Vitamin B7", ingredientItem.vitamins.vitB7).display,
                if (ingredientItem.vitamins.vitB9 != '0 g') TableInfoCell("Vitamin B9", ingredientItem.vitamins.vitB9).display,
                if (ingredientItem.vitamins.vitB12 != '0 g') TableInfoCell("Vitamin B12", ingredientItem.vitamins.vitB12).display,
                if (ingredientItem.vitamins.vitC != '0 g') TableInfoCell("Vitamin C", ingredientItem.vitamins.vitC).display,
                if (ingredientItem.vitamins.vitD != '0 g') TableInfoCell("Vitamin D", ingredientItem.vitamins.vitD).display,
                if (ingredientItem.vitamins.vitE != '0 g') TableInfoCell("Vitamin E", ingredientItem.vitamins.vitE).display,
                if (ingredientItem.vitamins.vitK != '0 g') TableInfoCell("Vitamin K", ingredientItem.vitamins.vitK).display,
                if (ingredientItem.minerals.calcium != '0 g') TableInfoCell("Calcium", ingredientItem.minerals.calcium).display,
                if (ingredientItem.minerals.chloride != '0 g') TableInfoCell("Chloride", ingredientItem.minerals.chloride).display,
                if (ingredientItem.minerals.chromium != '0 g') TableInfoCell("Chromium", ingredientItem.minerals.chromium).display,
                if (ingredientItem.minerals.copper != '0 g') TableInfoCell("Copper", ingredientItem.minerals.copper).display,
                if (ingredientItem.minerals.fluoride != '0 g') TableInfoCell("Fluoride", ingredientItem.minerals.fluoride).display,
                if (ingredientItem.minerals.iodine != '0 g') TableInfoCell("Iodine", ingredientItem.minerals.iodine).display,
                if (ingredientItem.minerals.iron != '0 g') TableInfoCell("Iron", ingredientItem.minerals.iron).display,
                if (ingredientItem.minerals.magnesium != '0 g') TableInfoCell("Magnesium", ingredientItem.minerals.magnesium).display,
                if (ingredientItem.minerals.manganese != '0 g') TableInfoCell("Manganese", ingredientItem.minerals.manganese).display,
                if (ingredientItem.minerals.molybdenum != '0 g') TableInfoCell("Molybdenum", ingredientItem.minerals.molybdenum).display,
                if (ingredientItem.minerals.phosphorus != '0 g') TableInfoCell("Phosphorus", ingredientItem.minerals.phosphorus).display,
                if (ingredientItem.minerals.potassium != '0 g') TableInfoCell("Potassium", ingredientItem.minerals.potassium).display,
                if (ingredientItem.minerals.selenium != '0 g') TableInfoCell("Selenium", ingredientItem.minerals.selenium).display,
                if (ingredientItem.minerals.sodium != '0 g') TableInfoCell("Sodium", ingredientItem.minerals.sodium).display,
                if (ingredientItem.minerals.zinc != '0 g') TableInfoCell("Zink", ingredientItem.minerals.zinc).display,
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
