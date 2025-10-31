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

  static const List<String> _categories = [
    'All',
    'Beach',
    'Adventure',
    'City',
    'Cultural',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DestinationsBloc, DestinationsState>(
          builder: (context, state) => SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String category = _categories[index];
                return FilterChip(
                  label: Text(category),
                  onSelected: (value) {
                    context.read<DestinationsBloc>().add(
                      GetDestinationsByCategory(category: category),
                    );
                  },
                  selected: category == state.selectedCategory,
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemCount: _categories.length,
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<DestinationsBloc, DestinationsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.message.isNotEmpty) {
                return Center(child: Text(state.message));
              }

              return ListView.builder(
                itemCount: state.destinations.length,
                itemBuilder: (context, index) {
                  final Destination destination = state.destinations[index];
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
