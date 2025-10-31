import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_state.dart';
import 'package:easy_travel/features/home/presentation/destination_card.dart';
import 'package:easy_travel/features/home/presentation/destination_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryType.values;

    return Column(
      children: [
        BlocSelector<DestinationsBloc, DestinationsState, CategoryType>(
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
                      context.read<DestinationsBloc>().add(
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
                DestinationsBloc,
                DestinationsState,
                (bool, String, List<Destination>)
              >(
                selector: (state) =>
                    (state.isLoading, state.message, state.destinations),
                builder: (context, state) {
                  final (isLoading, message, destinations) = state;
                  if (isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (message.isNotEmpty) {
                    return Center(child: Text(message));
                  }

                  return ListView.builder(
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final Destination destination = destinations[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DestinationDetailPage(destination: destination),
                          ),
                        ),
                        child: DestinationCard(destination: destination),
                      );
                    },
                  );
                },
              ),
        ),
      ],
    );
  }
}
