// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

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
          subtitle: Text(AppLocalizations.of(parentContext)!.calories + ": ${ingredientItem.calories}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
          children: [
            Align(alignment: Alignment.centerLeft, child: Text(AppLocalizations.of(parentContext)!.amount + ": ${ingredientItem.amount}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
            const SizedBox(height: 5),
            Align(alignment: Alignment.centerLeft, child: Text(AppLocalizations.of(parentContext)!.txt_facts + ": ", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
            const SizedBox(height: 5),
            Table(
              border: TableBorder.all(borderRadius: BorderRadius.circular(5)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableInfoCell(AppLocalizations.of(parentContext)!.fact_totalfat, ingredientItem.totalFat).display,
                if (ingredientItem.satFat != '0 g') TableInfoCell("${"─" * 2} " + AppLocalizations.of(parentContext)!.fact_satfat, ingredientItem.satFat).display,
                if (ingredientItem.transFat != '0 g') TableInfoCell("${"─" * 2} " + AppLocalizations.of(parentContext)!.fact_transfat, ingredientItem.transFat).display,
                TableInfoCell(AppLocalizations.of(parentContext)!.fact_cholesterol, ingredientItem.cholesterol).display,
                TableInfoCell(AppLocalizations.of(parentContext)!.fact_totalcarb, ingredientItem.totalCarb).display,
                TableInfoCell("${"─" * 2} " + AppLocalizations.of(parentContext)!.fact_fiber, ingredientItem.dietaryFiber).display,
                if (ingredientItem.sugar != '0 g') TableInfoCell("${"─" * 2} " + AppLocalizations.of(parentContext)!.fact_sugar, ingredientItem.sugar).display,
                if (ingredientItem.protein != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_protein, ingredientItem.protein).display,
                if (ingredientItem.vitamins.vitA != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " A", ingredientItem.vitamins.vitA).display,
                if (ingredientItem.vitamins.vitB1 != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " B1", ingredientItem.vitamins.vitB1).display,
                if (ingredientItem.vitamins.vitB2 != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " B2", ingredientItem.vitamins.vitB2).display,
                if (ingredientItem.vitamins.vitB3 != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " B3", ingredientItem.vitamins.vitB3).display,
                if (ingredientItem.vitamins.vitB5 != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " B5", ingredientItem.vitamins.vitB5).display,
                if (ingredientItem.vitamins.vitB6 != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " B6", ingredientItem.vitamins.vitB6).display,
                if (ingredientItem.vitamins.vitB7 != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " B7", ingredientItem.vitamins.vitB7).display,
                if (ingredientItem.vitamins.vitB9 != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " B9", ingredientItem.vitamins.vitB9).display,
                if (ingredientItem.vitamins.vitB12 != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " B12", ingredientItem.vitamins.vitB12).display,
                if (ingredientItem.vitamins.vitC != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " C", ingredientItem.vitamins.vitC).display,
                if (ingredientItem.vitamins.vitD != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " D", ingredientItem.vitamins.vitD).display,
                if (ingredientItem.vitamins.vitE != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " E", ingredientItem.vitamins.vitE).display,
                if (ingredientItem.vitamins.vitK != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_vitamin + " K", ingredientItem.vitamins.vitK).display,
                if (ingredientItem.minerals.calcium != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_calcium, ingredientItem.minerals.calcium).display,
                if (ingredientItem.minerals.chloride != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_chloride, ingredientItem.minerals.chloride).display,
                if (ingredientItem.minerals.chromium != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_chromium, ingredientItem.minerals.chromium).display,
                if (ingredientItem.minerals.copper != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_copper, ingredientItem.minerals.copper).display,
                if (ingredientItem.minerals.fluoride != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_fluoride, ingredientItem.minerals.fluoride).display,
                if (ingredientItem.minerals.iodine != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_iodine, ingredientItem.minerals.iodine).display,
                if (ingredientItem.minerals.iron != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_iron, ingredientItem.minerals.iron).display,
                if (ingredientItem.minerals.magnesium != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_magnesium, ingredientItem.minerals.magnesium).display,
                if (ingredientItem.minerals.manganese != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_manganese, ingredientItem.minerals.manganese).display,
                if (ingredientItem.minerals.molybdenum != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_molybdenum, ingredientItem.minerals.molybdenum).display,
                if (ingredientItem.minerals.phosphorus != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_phosphorus, ingredientItem.minerals.phosphorus).display,
                if (ingredientItem.minerals.potassium != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_potassium, ingredientItem.minerals.potassium).display,
                if (ingredientItem.minerals.selenium != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_selenium, ingredientItem.minerals.selenium).display,
                if (ingredientItem.minerals.sodium != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_sodium, ingredientItem.minerals.sodium).display,
                if (ingredientItem.minerals.zinc != '0 g') TableInfoCell(AppLocalizations.of(parentContext)!.fact_zink, ingredientItem.minerals.zinc).display,
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
