import 'package:easy_travel/features/favorites/blocs/favorites_bloc.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_event.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.destination});
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Image.network(destination.posterPath, height: 40, width: 40),
          IconButton(
            onPressed: () =>
                context.read<FavoritesBloc>().add(RemoveFavorite(id: destination.id)),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
