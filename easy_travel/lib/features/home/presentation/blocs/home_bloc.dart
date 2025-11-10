import 'dart:async';
import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/data/destination_dao.dart';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_state.dart';
import 'package:easy_travel/features/home/presentation/models/destination_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DestinationService service;
  final DestinationDao dao;
  HomeBloc({required this.service, required this.dao}) : super(HomeState()) {
    on<GetDestinationsByCategory>(_getDestinationsByCategory);
    on<ToggleFavorite>(_toggleFavorite);
  }

  FutureOr<void> _toggleFavorite(
    ToggleFavorite event,
    Emitter<HomeState> emit,
  ) async {
    final List<Destination> favorites = await dao.fetchAll();
    final List<int> ids = favorites.map((favorite) => favorite.id).toList();

    final Destination destination = event.destination;
    final bool isFavorite = ids.contains(destination.id);

    if (isFavorite) {
      await dao.delete(destination.id);
    } else {
      await dao.insert(destination);
    }

    final List<DestinationUi> updateList = state.destinations.map((
      destination,
    ) {
      return DestinationUi(
        destination: destination.destination,
        isFavorite: event.destination.id == destination.destination.id
            ? !destination.isFavorite
            : destination.isFavorite,
      );
    }).toList();

    emit(state.copyWith(destinations: updateList));
  }

  FutureOr<void> _getDestinationsByCategory(
    GetDestinationsByCategory event,
    Emitter<HomeState> emit,
  ) async {
    if (event.category == state.selectedCategory &&
        state.destinations.isNotEmpty) {
      return;
    }

    emit(
      state.copyWith(status: Status.loading, selectedCategory: event.category),
    );
    try {
      final destinations = await service.getDestinations(
        category: event.category,
      );
      final List<Destination> favorites = await dao.fetchAll();
      final List<int> ids = favorites.map((favorite) => favorite.id).toList();

      final items = destinations
          .map(
            (item) => DestinationUi(
              destination: item,
              isFavorite: ids.contains(item.id),
            ),
          )
          .toList();
      emit(state.copyWith(status: Status.success, destinations: items));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
