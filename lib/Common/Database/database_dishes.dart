import 'dart:io';
import 'package:bt/Screens/HomePage/dishes_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;
  static const String tableDish = "DishesTable";

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  initDatabase() async {
    Directory docdir = await getApplicationDocumentsDirectory();
    String path = join(docdir.path, 'app.db');
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $tableDish '
        '(id INTEGER PRIMARY KEY '
        'AUTOINCREMENT,'
        ' title TEXT,'
        ' ingredients TEXT,'
        ' category TEXT,'
        ' steps TEXT'
        ')');
  }

 
  Future<Dish> addDish(Dish dish) async {
    var dbClient = await db;
    dish.id = await dbClient.insert(tableDish, dish.toJson());
    return dish;
  }

    getAllDishes() async {
    var dbClient = await db;
    List maps = await dbClient.query(tableDish,
        columns: ['id', 'title', 'ingredients', 'category', 'steps']);

    List<Dish> disheList = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        disheList.add(Dish.fromJson(maps[i]));
      }
    }
    return disheList;
  }

    Future<int> update(note) async {
    final dbClient = await db;
    return dbClient.update(
      tableDish,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

    Future<void> deleteTable() async {
    var dbClient = await db;
    await dbClient.delete(tableDish);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      tableDish,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}