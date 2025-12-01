import 'package:easy_meal/domain/models/category.dart';
import 'package:easy_meal/presentation/blocs/category_state.dart';
import 'package:easy_meal/presentation/blocs/meal_bloc.dart';
import 'package:easy_meal/presentation/blocs/meal_state.dart';
import 'package:easy_meal/presentation/widgets/meal_list.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  category.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ExpandableText(
                          category.description,
                          expandText: 'Show more',
                          collapseText: 'Show less',
                          animation: true,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 8.0,
                    ),
                    child: BlocBuilder<MealBloc, MealState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case Status.initial:
                            return const Center(child: SizedBox.shrink());
                          case Status.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case Status.success:
                            return MealList(meals: state.meals);
                          case Status.failure:
                            return Center(child: Text('${state.message}'));
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
