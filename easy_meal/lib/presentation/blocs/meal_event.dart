import 'package:easy_meal/domain/models/meal.dart';

abstract class MealEvent {
  const MealEvent();
}

class GetMealsByCategory extends MealEvent {
  final String category;
  const GetMealsByCategory({required this.category});
}

class ToggleMealFavorite extends MealEvent {
  final Meal meal;
  const ToggleMealFavorite({required this.meal});
}
