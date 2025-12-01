import 'package:easy_meal/data/local/meal_dao.dart';
import 'package:easy_meal/data/remote/category_service.dart';
import 'package:easy_meal/data/remote/meal_service.dart';
import 'package:easy_meal/data/repositories/category_repository_impl.dart';
import 'package:easy_meal/data/repositories/meal_repository_impl.dart';
import 'package:easy_meal/domain/repositories/category_repository.dart';
import 'package:easy_meal/domain/repositories/meal_repository.dart';
import 'package:easy_meal/presentation/blocs/category_bloc.dart';
import 'package:easy_meal/presentation/blocs/category_event.dart';
import 'package:easy_meal/presentation/blocs/meal_bloc.dart';
import 'package:easy_meal/presentation/pages/categories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryRepository categoryRepository = CategoryRepositoryImpl(
      service: CategoryService(),
    );
    MealRepository mealRepository = MealRepositoryImpl(
      service: MealService(),
      dao: MealDao(),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoryBloc(repository: categoryRepository)
                ..add(GetAllCategories()),
        ),
        BlocProvider(create: (context) => MealBloc(repository: mealRepository)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CategoriesPage(),
      ),
    );
  }
}
