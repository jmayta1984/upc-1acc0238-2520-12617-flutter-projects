import 'dart:async';
import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/domain/destination_repository.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_state.dart';
import 'package:easy_travel/features/home/presentation/models/destination_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DestinationRepository repository;
  HomeBloc({required this.repository}) : super(HomeState()) {
    on<GetDestinationsByCategory>(_getDestinationsByCategory);
    on<ToggleFavorite>(_toggleFavorite);
  }

  FutureOr<void> _toggleFavorite(
    ToggleFavorite event,
    Emitter<HomeState> emit,
  ) async {
    await repository.toggleFavorite(event.destination);

    final favoriteIds = await repository.getFavoriteIds();

    final List<DestinationUi> updateList = state.destinations.map((
      destination,
    ) {
      return DestinationUi(
        destination: destination.destination,
        isFavorite: favoriteIds.contains(destination.destination.id)
      );
    }).toList();

    emit(state.copyWith(destinations: updateList));
  }

  FutureOr<void> _getDestinationsByCategory(
    GetDestinationsByCategory event,
    Emitter<HomeState> emit,
  ) async {
    /*
    if (event.category == state.selectedCategory &&
        state.destinations.isNotEmpty) {
      return;
    }
    */

    emit(
      state.copyWith(status: Status.loading, selectedCategory: event.category),
    );
    try {
      final destinations = await repository.getDestinationsByCategory(
        event.category,
      );
      final ids = await repository.getFavoriteIds();

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
