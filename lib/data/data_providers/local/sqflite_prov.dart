// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/data/models/recipe_model.dart';

class DatabaseProvider {
  static const String TABLE_RECIPE = "Recipe";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_ORIGIN = "origin";
  static const String COLUMN_CATEGORY = "category";
  static const String COLUMN_THUMBNAIL = "thumbnail";
  static const String COLUMN_INGREDIENTS = "ingredients";
  static const String COLUMN_INSTRUCTION = "instruction";
  // static const String COLUMN_VEGAN = "isvegan";

  DatabaseProvider.init();
  static final DatabaseProvider db = DatabaseProvider.init();

  Future<Database> get database async {
    var newDatabase = await createDatabase();
    return newDatabase;
  }

  Future<Database> createDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'recipes.db');

    if (await Directory(dirname(path)).exists()) {
      return initExecute(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
        return initExecute(path);
      } catch (e) {
        print("++ ERROR: $e ++");
      }
      throw UnimplementedError();
    }
  }

  Future<Database> initExecute(String dbpath) async {
    return await openDatabase(
      dbpath,
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating Recipe table");
        await database.execute(
          "CREATE TABLE $TABLE_RECIPE ("
          "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$COLUMN_NAME TEXT,"
          "$COLUMN_ORIGIN TEXT,"
          "$COLUMN_CATEGORY TEXT,"
          "$COLUMN_THUMBNAIL TEXT,"
          "$COLUMN_INGREDIENTS TEXT,"
          "$COLUMN_INSTRUCTION TEXT"
          // "$COLUMN_VEGAN INTEGER"
          ")",
        );
      },
    );
  }

  Future<List<Recipe>> getFoods() async {
    print("Fetching Foods from Database...");
    final databaseActual = await db.database;
    var foods = await databaseActual.query(TABLE_RECIPE, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_ORIGIN, COLUMN_CATEGORY, COLUMN_THUMBNAIL, COLUMN_INGREDIENTS, COLUMN_INSTRUCTION]);
    // print("DB Log: $foods");
    List<Recipe> foodList = [];
    foods.forEach((currentFood) {
      Recipe food = Recipe.nullRecipe.fromMap(currentFood);
      foodList.add(food);
    });
    return foodList;
  }

  Future<int> insert(Recipe entry) async {
    print("Inserting Foods in Database...");
    final databaseActual = await db.database;
    var id = await databaseActual.insert(TABLE_RECIPE, entry.toMap()); //, conflictAlgorithm: ConflictAlgorithm.replace
    print('Item #$id was Inserted in Database');
    return id;
  }

  Future<int> delete(Recipe entry) async {
    print("Deleting Foods from Database...");
    final databaseActual = await db.database;
    var id = entry.id!;

    await databaseActual.delete(TABLE_RECIPE, where: "id = ?", whereArgs: [id]);
    print('Item #$id was Deleted from Database');
    return id;
  }

  Future<int> update(Recipe entry) async {
    print("Updating Foods in Database...");
    final databaseActual = await db.database;
    var id = entry.id!;

    await databaseActual.update(TABLE_RECIPE, entry.toMap(), where: "id = ?", whereArgs: [id]);
    print('Item #$id was Modified in Database');
    return id;
  }

  void close() async {
    print("Closing Recipe Database...");
    //TODO - Should specify the database I want to close
    final databaseActual = await db.database;
    await databaseActual.close();
  }
}
