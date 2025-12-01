import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/presentation/blocs/meal_bloc.dart';
import 'package:easy_meal/presentation/blocs/meal_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        ClipOval(
          child: Image.network(
            meal.posterPath,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Text(meal.name, style: Theme.of(context).textTheme.bodyMedium),
        ),
        IconButton(
          onPressed: () =>
              context.read<MealBloc>().add(ToggleMealFavorite(meal: meal)),
          icon: Icon(meal.isFavorite ? Icons.favorite : Icons.favorite_border),
        ),
      ],
    );
  }
}
