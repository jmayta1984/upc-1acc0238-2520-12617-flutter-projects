import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/presentation/blocs/category_state.dart';

class MealState {
  final Status status;
  final List<Meal> meals;
  final String? message;

  const MealState({
    this.status = Status.initial,
    this.meals = const [],
    this.message,
  });

  MealState copyWith({
    Status? status,
    List<Meal>? meals,
    String? message,
  }) {
    return MealState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      message: message ?? this.message,
    );
  }
}