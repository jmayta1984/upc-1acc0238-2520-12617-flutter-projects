import 'package:easy_meal/presentation/blocs/category_bloc.dart';
import 'package:easy_meal/presentation/blocs/category_state.dart';
import 'package:easy_meal/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.initial:
              return const Center(child: SizedBox.shrink());
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.success:
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return CategoryCard(category: category);
                },
              );
            case Status.failure:
              return Center(child: Text('Error: ${state.message}'));
          }
        },
      ),
    );
  }
}
