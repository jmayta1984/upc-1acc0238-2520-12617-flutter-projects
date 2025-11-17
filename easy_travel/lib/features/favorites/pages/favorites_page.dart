import 'package:easy_travel/features/favorites/blocs/favorites_bloc.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_state.dart';
import 'package:easy_travel/features/favorites/widgets/favorite_card.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listenWhen: (previous, current) => previous.destinations != current.destinations,
      listener: (context, state) => context.read<HomeBloc>().add(
        GetDestinationsByCategory(category: CategoryType.all),
      ),
      builder: (context, state) => ListView.builder(
        itemCount: state.destinations.length,
        itemBuilder: (context, index) {
          final Destination destination = state.destinations[index];
          return FavoriteCard(destination: destination);
        },
      ),
    );
  }
}
