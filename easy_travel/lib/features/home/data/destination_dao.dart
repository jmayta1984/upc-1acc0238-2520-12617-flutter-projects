import 'package:easy_travel/core/database/app_database.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:sqflite/sqflite.dart';

class DestinationDao {
  const DestinationDao();

  Future<void> insert(Destination destination) async {
    final Database db = await AppDatabase().database;
    await db.insert('destinations', destination.toMap());
  }

  Future<void> delete(int id) async {
    final Database db = await AppDatabase().database;
    await db.delete('destinations', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Destination>> fetchAll() async {
    final Database db = await AppDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query('destinations');
    return maps.map((map) => Destination.fromMap(map)).toList();
  }
}
