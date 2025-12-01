import 'package:easy_meal/domain/models/meal.dart';

class MealDto {
  final String id;
  final String name;
  final String posterPath;

  const MealDto({
    required this.id,
    required this.name,
    required this.posterPath,
  });
  
  factory MealDto.fromJson(Map<String, dynamic> json) {
    return MealDto(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      posterPath: json['strMealThumb'] as String,
    );
  }

  Meal toDomain() {
    return Meal(
      id: id,
      name: name,
      posterPath: posterPath,
      isFavorite: false,
    );
  }
}