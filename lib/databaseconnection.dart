import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/models/task.dart';

class DatabaseHelper {
  Future<Database> database() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'todo_database.db'),
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)');
      },
    );
  }

  Future<int> insertTask(Task task) async {
    Database db = await database();
    int taskId = 0;
    await db
        .insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .then((value) {
      taskId = value;
    });

    return taskId;
  }

  Future<void> updateTaskTitle(int id, String value) async {
    Database db = await database();
    Task task = Task(id: id, title: value);
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id=?',
      whereArgs: [task.id],
    );
  }

  Future<List<Task>> getTask() async {
    Database db = await database();
    List<Map<String, dynamic>> taskMap = await db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
        id: taskMap[index]['id'],
        title: taskMap[index]['title'],
        description: taskMap[index]['description'],
      );
    });
  }

  Future<void> deleteTask(int? id) async {
    Database db = await database();
    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
