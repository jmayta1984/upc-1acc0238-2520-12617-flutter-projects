import 'package:easy_meal/domain/models/category.dart';
import 'package:easy_meal/presentation/blocs/meal_bloc.dart';
import 'package:easy_meal/presentation/blocs/meal_event.dart';
import 'package:easy_meal/presentation/pages/category_page.dart';
import 'package:easy_meal/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            context.read<MealBloc>().add(
              GetMealsByCategory(category: category.name),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPage(category: category),
              ),
            );
          },
          child: CategoryCard(category: category),
        );
      },
    );
  }
}
