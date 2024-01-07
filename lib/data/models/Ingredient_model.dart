// ignore_for_file: unused_import, must_be_immutable

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:test/data/data_providers/local/sqflite_prov.dart';

class Ingredient extends Equatable {
  final int? id;
  final String name;
  final String description;
  final String? thumbnail;
  final int amount;
  final int calories;
  final String sugar;
  final String satFat;
  final String protein;
  final String transFat;
  final String totalFat;
  final String totalCarb;
  final String cholesterol;
  final String dietaryFiber;
  final Vitamins vitamins;
  final Minerals minerals;

  const Ingredient({
    this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.amount,
    required this.calories,
    required this.totalFat,
    required this.satFat,
    required this.transFat,
    required this.cholesterol,
    required this.totalCarb,
    required this.dietaryFiber,
    required this.sugar,
    required this.protein,
    required this.vitamins,
    required this.minerals,
  });

  @override
  List<Object?> get props => [id, name, description, amount, calories, totalFat, satFat, transFat, cholesterol, totalCarb, dietaryFiber, sugar, protein, vitamins];

  //Parsing Supabase Item to App Object
  factory Ingredient.fromSupaJSON(Map<String, dynamic> jsonIngredient) {
    var supaId = jsonIngredient['ingId'];
    var supaName = jsonIngredient['ingName'] ?? 'NULL';
    var supaDesc = jsonIngredient['ingDescription'] ?? 'NULL';
    var supaThumb = jsonIngredient['ingThumb'] ?? 'NULL';
    var supaAmount = jsonIngredient['ingAmount'] ?? 100;
    var supaCalories = jsonIngredient['ingCalories'] ?? 0;
    var supaSugar = (jsonIngredient['ingSugar'] ?? '0 g');
    var supaProtein = (jsonIngredient['ingProtein'] ?? '0 g');
    var supaTransFat = (jsonIngredient['ingTransFat'] ?? '0 g');
    var supaTotalFat = (jsonIngredient['ingTotalFat'] ?? '0 g');
    var supaTotalCarb = (jsonIngredient['ingTotalCarb'] ?? '0 g');
    var supaSatFat = (jsonIngredient['ingSaturatedFat'] ?? '0 g');
    var supaCholesterol = (jsonIngredient['ingCholesterol'] ?? '0 g');
    var supaDietaryFiber = (jsonIngredient['ingDietaryFiber'] ?? '0 g');

    var supaVitA = jsonIngredient['ingVitA'] ?? '0 g';
    var supaVitB1 = jsonIngredient['ingVitB1'] ?? '0 g';
    var supaVitB2 = jsonIngredient['ingVitB2'] ?? '0 g';
    var supaVitB3 = jsonIngredient['ingVitB3'] ?? '0 g';
    var supaVitB5 = jsonIngredient['ingVitB5'] ?? '0 g';
    var supaVitB6 = jsonIngredient['ingVitB6'] ?? '0 g';
    var supaVitB7 = jsonIngredient['ingVitB7'] ?? '0 g';
    var supaVitB9 = jsonIngredient['ingVitB9'] ?? '0 g';
    var supaVitB12 = jsonIngredient['ingVitB12'] ?? '0 g';
    var supaVitC = jsonIngredient['ingVitC'] ?? '0 g';
    var supaVitD = jsonIngredient['ingVitD'] ?? '0 g';
    var supaVitE = jsonIngredient['ingVitE'] ?? '0 g';
    var supaVitK = jsonIngredient['ingVitK'] ?? '0 g';

    var supaMinIron = jsonIngredient['ingMinIron'] ?? '0 g';
    var supaMinZinc = jsonIngredient['ingMinZinc'] ?? '0 g';
    var supaMinCopper = jsonIngredient['ingMinCopper'] ?? '0 g';
    var supaMinSodium = jsonIngredient['ingMinSodium'] ?? '0 g';
    var supaMinIodine = jsonIngredient['ingMinIodine'] ?? '0 g';
    var supaMinCalcium = jsonIngredient['ingMinCalcium'] ?? '0 g';
    var supaMinFluoride = jsonIngredient['ingMinFluoride'] ?? '0 g';
    var supaMinChloride = jsonIngredient['ingMinChloride'] ?? '0 g';
    var supaMinChromium = jsonIngredient['ingMinChromium'] ?? '0 g';
    var supaMinSelenium = jsonIngredient['ingMinSelenium'] ?? '0 g';
    var supaMinManganese = jsonIngredient['ingMinManganese'] ?? '0 g';
    var supaMinPotassium = jsonIngredient['ingMinPotassium'] ?? '0 g';
    var supaMinMagnesium = jsonIngredient['ingMinMagnesium'] ?? '0 g';
    var supaMinPhosphorus = jsonIngredient['ingMinPhosphorus'] ?? '0 g';
    var supaMinMolybdenum = jsonIngredient['ingMinMolybdenum'] ?? '0 g';

    var supaMinerals = Minerals(
        calcium: supaMinCalcium,
        chloride: supaMinChloride,
        chromium: supaMinChromium,
        copper: supaMinCopper,
        fluoride: supaMinFluoride,
        iodine: supaMinIodine,
        iron: supaMinIron,
        magnesium: supaMinMagnesium,
        manganese: supaMinManganese,
        molybdenum: supaMinMolybdenum,
        phosphorus: supaMinPhosphorus,
        potassium: supaMinPotassium,
        selenium: supaMinSelenium,
        sodium: supaMinSodium,
        zinc: supaMinZinc);

    var supaVitamins = Vitamins(
      vitA: supaVitA,
      vitB1: supaVitB1,
      vitB2: supaVitB2,
      vitB3: supaVitB3,
      vitB5: supaVitB5,
      vitB6: supaVitB6,
      vitB7: supaVitB7,
      vitB9: supaVitB9,
      vitB12: supaVitB12,
      vitC: supaVitC,
      vitD: supaVitD,
      vitE: supaVitE,
      vitK: supaVitK,
    );

    var result = Ingredient(
      id: supaId,
      name: supaName,
      description: supaDesc,
      thumbnail: supaThumb,
      amount: supaAmount,
      calories: supaCalories,
      totalFat: supaTotalFat,
      satFat: supaSatFat,
      transFat: supaTransFat,
      cholesterol: supaCholesterol,
      totalCarb: supaTotalCarb,
      dietaryFiber: supaDietaryFiber,
      sugar: supaSugar,
      protein: supaProtein,
      vitamins: supaVitamins,
      minerals: supaMinerals,
    );
    return result;
  }

  static Ingredient nullIngredient = const Ingredient(
    id: -1,
    name: 'NULL',
    description: 'NULL',
    thumbnail: 'NULL',
    amount: 100,
    calories: 0,
    totalFat: '0 g',
    satFat: '0 g',
    transFat: '0 g',
    cholesterol: '0 g',
    totalCarb: '0 g',
    dietaryFiber: '0 g',
    sugar: '0 g',
    protein: '0 g',
    vitamins: Vitamins(),
    minerals: Minerals(),
  );
}

class Minerals extends Equatable {
  final String iron;
  final String zinc;
  final String copper;
  final String sodium;
  final String iodine;
  final String calcium;
  final String fluoride;
  final String chloride;
  final String chromium;
  final String selenium;
  final String manganese;
  final String potassium;
  final String magnesium;
  final String phosphorus;
  final String molybdenum;

  const Minerals({
    this.iron = '0 g',
    this.zinc = '0 g',
    this.copper = '0 g',
    this.sodium = '0 g',
    this.iodine = '0 g',
    this.calcium = '0 g',
    this.fluoride = '0 g',
    this.chloride = '0 g',
    this.chromium = '0 g',
    this.selenium = '0 g',
    this.manganese = '0 g',
    this.potassium = '0 g',
    this.magnesium = '0 g',
    this.phosphorus = '0 g',
    this.molybdenum = '0 g',
  });

  @override
  List<Object?> get props => [iron, zinc, copper, sodium, iodine, calcium, fluoride, chloride, chromium, selenium, manganese, potassium, magnesium, phosphorus, molybdenum];
}

class Vitamins extends Equatable {
  final String vitA;
  final String vitC;
  final String vitD;
  final String vitE;
  final String vitK;
  final String vitB1;
  final String vitB2;
  final String vitB3;
  final String vitB5;
  final String vitB6;
  final String vitB7;
  final String vitB9;
  final String vitB12;

  const Vitamins({
    this.vitA = '0 g',
    this.vitC = '0 g',
    this.vitD = '0 g',
    this.vitE = '0 g',
    this.vitK = '0 g',
    this.vitB1 = '0 g',
    this.vitB2 = '0 g',
    this.vitB3 = '0 g',
    this.vitB5 = '0 g',
    this.vitB6 = '0 g',
    this.vitB7 = '0 g',
    this.vitB9 = '0 g',
    this.vitB12 = '0 g',
  });

  @override
  List<Object?> get props => [vitA, vitC, vitD, vitE, vitK, vitB1, vitB2, vitB3, vitB5, vitB6, vitB7, vitB9, vitB12];
}
