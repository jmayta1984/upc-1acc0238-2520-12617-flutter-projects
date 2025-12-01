import 'package:easy_meal/core/constants/database_constants.dart';
import 'package:easy_meal/core/database/app_database.dart';
import 'package:easy_meal/data/models/meal_entity.dart';
import 'package:sqflite/sqflite.dart';

class MealDao {
  Future<void> insertFavorite(MealEntity entity) async {
    final Database database = await AppDatabase().database;
    await database.insert(DatabaseConstants.mealsTable, entity.toMap());
  }

  Future<void> deleteFavorite(String id) async {
    final Database database = await AppDatabase().database;
    await database.delete(
      DatabaseConstants.mealsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Set<String>> getFavoriteMealIds() async {
    final Database database = await AppDatabase().database;
    final List maps = await database.query(DatabaseConstants.mealsTable);
    return maps.map((map) => map['id'] as String).toSet();
  }
}
