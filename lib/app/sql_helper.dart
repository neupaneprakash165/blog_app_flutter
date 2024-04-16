import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase('post.db', version: 1, onCreate: (
      sql.Database database,
      int version,
    ) async {
      await createTables(database);
    });
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE post(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            title TEXT,
            content TEXT,
            imagePath TEXT
    )""");
  }

//post item
  static Future<int> createPost(Map<String, dynamic> data) async {
    final db = await SQLHelper.db();
    final id = await db.insert('post', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getPosts() async {
    final db = await SQLHelper.db();
    return db.query('post', orderBy: "id");
  }

  static Future<int> updatePost(int id, dynamic data) async {
    final db = await SQLHelper.db();
    final result =
        await db.update('post', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<int> deletePost(int id) async {
    final db = await SQLHelper.db();
    final result = db.delete("post", where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<List<Map<String, dynamic>>> findPosts(String value) async {
    String searchString1 = '$value%';
    String searchString2 = '$value%';
    final db = await SQLHelper.db();
    return await db.query(
      'post',
      where: 'title LIKE  ? OR content LIKE ?',
      whereArgs: [searchString1, searchString2],
    );
  }

  static Future<void> truncatePost() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("post");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
