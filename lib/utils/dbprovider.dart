import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:toduelist/models/Task.dart';
import 'dart:io';
import 'dart:async';

class DbProvider {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path, "tasks.db"); //create path to database

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 1, onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          body TEXT,
          done BOOL)
          """);
    });
  }

  Future<int> addTask(Task task) async {
    final db = await init();

    return db.insert(
      "tasks",
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Task>> fetchTasks() async {
    final db = await init();
    final maps = await db.query("tasks", where: "done = 0");

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        body: maps[i]['body'],
        done: maps[i]['done'],
      );
    });
  }

  Future<List<Task>> fetchDoneTasks() async {
    final db = await init();
    final maps = await db.query("tasks", where: "done = 1");

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        body: maps[i]['body'],
        done: maps[i]['done'],
      );
    });
  }

  Future<int> deleteTask(int id) async {
    final db = await init();

    int result = await db.delete(
      "tasks",
      where: "id = ?",
      whereArgs: [id],
    );

    return result;
  }

  Future<int> updateTask(int id, Task item) async {
    final db = await init();

    int result = await db.update(
      "tasks",
      item.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }
}
