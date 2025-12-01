import 'package:easy_meal/domain/models/meal.dart';

class MealEntity {
  final String id;
  final String name;
  final String posterPath;

  const MealEntity({
    required this.id,
    required this.name,
    required this.posterPath,
  });

  factory MealEntity.fromMap(Map<String, dynamic> map) {
    return MealEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      posterPath: map['poster_path'] as String,
    );
  }

  factory MealEntity.fromDomain(Meal meal) {
    return MealEntity(
      id: meal.id,
      name: meal.name,
      posterPath: meal.posterPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
    };
  }
}