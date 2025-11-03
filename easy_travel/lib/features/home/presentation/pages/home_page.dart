import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_state.dart';
import 'package:easy_travel/features/home/presentation/widgets/destination_card.dart';
import 'package:easy_travel/features/home/presentation/pages/destination_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryType.values;

    return Column(
      children: [
        BlocSelector<HomeBloc, HomeState, CategoryType>(
          selector: (state) => (state.selectedCategory),
          builder: (context, state) {
            return SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return FilterChip(
                    label: Text(category.label),
                    onSelected: (value) {
                      context.read<HomeBloc>().add(
                        GetDestinationsByCategory(category: category),
                      );
                    },
                    selected: category == state,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: categories.length,
              ),
            );
          },
        ),
        Expanded(
          child:
              BlocSelector<
                HomeBloc,
                HomeState,
                (Status, List<Destination>, String?)
              >(
                selector: (state) =>
                    (state.status, state.destinations, state.message),
                builder: (context, state) {
                  final (status, destinations, message) = state;
                  switch (status) {
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator());
                    case Status.failure:
                      return Center(child: Text(message ?? 'Unknown error'));
                    case Status.success:
                      return ListView.builder(
                        itemCount: destinations.length,
                        itemBuilder: (context, index) {
                          final Destination destination = destinations[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DestinationDetailPage(
                                  destination: destination,
                                ),
                              ),
                            ),
                            child: DestinationCard(destination: destination),
                          );
                        },
                      );
                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
        ),
      ],
    );
  }
}
