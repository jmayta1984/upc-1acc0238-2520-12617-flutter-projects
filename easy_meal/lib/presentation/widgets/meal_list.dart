import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/presentation/widgets/meal_card.dart';
import 'package:flutter/material.dart';

class MealList extends StatelessWidget {
  final List<Meal> meals;
  const MealList({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: meals.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text('Meals', style: Theme.of(context).textTheme.titleMedium);
        }
        final meal = meals[index - 1];
        return MealCard(meal: meal);
      },
    );
  }
}
