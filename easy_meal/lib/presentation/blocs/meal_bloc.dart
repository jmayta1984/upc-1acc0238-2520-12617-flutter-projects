import 'dart:async';
import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/domain/repositories/meal_repository.dart';
import 'package:easy_meal/presentation/blocs/category_state.dart';
import 'package:easy_meal/presentation/blocs/meal_event.dart';
import 'package:easy_meal/presentation/blocs/meal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository repository;
  MealBloc({required this.repository}) : super(const MealState()) {
    on<GetMealsByCategory>(_getMealsByCategory);
    on<ToggleMealFavorite>(_toggleMealFavorite);
  }

  FutureOr<void> _getMealsByCategory(
    GetMealsByCategory event,
    Emitter<MealState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<Meal> meals = await repository.getMealsByCategory(
        event.category,
      );
      emit(state.copyWith(status: Status.success, meals: meals));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  FutureOr<void> _toggleMealFavorite(
    ToggleMealFavorite event,
    Emitter<MealState> emit,
  ) async {
    await repository.toggleMealFavorite(event.meal);

    final updatedMeals = state.meals.map((meal) {
      if (meal.id == event.meal.id) {
        return meal.copyWith(isFavorite: !meal.isFavorite);
      }
      return meal;
    }).toList();
    emit(state.copyWith(meals: updatedMeals));
  }
}
