import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/habit.dart';

class DatabaseService {
  Database? _db;

  Future<void> initialize() async {
    if (_db != null) return;

    final String path = join(await getDatabasesPath(), 'habits.db');
    _db = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE habits(id INTEGER PRIMARY KEY, name TEXT, daysCompleted INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<Habit>> getHabits() async {
    final List<Map<String, dynamic>> maps = await _db!.query('habits');
    return maps.map((map) => Habit.fromMap(map)).toList();
  }

  Future<void> addHabit(String name) async {
    await _db!.insert('habits', {
      'name': name,
      'daysCompleted': 0,
    });
  }

  Future<void> incrementDay(int id, int currentDays) async {
    await _db!.update(
      'habits',
      {'daysCompleted': currentDays + 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void dispose() {
    _db?.close();
  }
}
