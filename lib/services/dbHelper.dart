import 'package:sqflite/sqflite.dart' as sqf;

class DBHelper {
  static Future<void> createTables(sqf.Database database) async {
    await database.execute(
        "CREATE TABLE favourites (id INTEGER PRIMARY KEY NOT NULL, title TEXT, servings INTEGER, addedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
  }

  static Future<sqf.Database> db() async {
    return sqf.openDatabase(
      'dbtech.db',
      version: 1,
      onCreate: (sqf.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(
      int recipeId, String title, int servings) async {
    final db = await DBHelper.db();

    final data = {'title': title, 'servings': servings, 'id': recipeId};
    final id = await db.insert('favourites', data,
        conflictAlgorithm: sqf.ConflictAlgorithm.replace);
    print(id);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBHelper.db();

    return db.query("favourites", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DBHelper.db();

    return db.query("favourites", where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.db();

    try {
      await db.delete('favourites', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("something went wrong");
    }
  }
}
