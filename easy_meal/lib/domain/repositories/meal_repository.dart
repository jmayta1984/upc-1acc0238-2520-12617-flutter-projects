import 'package:easy_meal/domain/models/meal.dart';

abstract class MealRepository {
  Future<List<Meal>> getMealsByCategory(String category);

  Future<void> toggleMealFavorite(Meal meal);
}
