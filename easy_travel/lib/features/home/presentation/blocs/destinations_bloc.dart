import 'dart:async';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DestinationsBloc extends Bloc<DestinationsEvent, DestinationsState> {
  final DestinationService service;
  DestinationsBloc({required this.service})
    : super(DestinationsState()) {
    on<GetDestinationsByCategory>(_getDestinationsByCategory);
    on<GetAllDestinations>(_getAllDestinations);
  }

  FutureOr<void> _getDestinationsByCategory(
    GetDestinationsByCategory event,
    Emitter emit,
  ) async {

    if (event.category == state.selectedCategory &&
      state.destinations.isNotEmpty) {
    return;
  }
  
    emit(
      state.copyWith(
        isLoading: true,
        selectedCategory: event.category,
        message: null,
      ),
    );
    try {
      final destinations = await service.getDestinations(
        category: event.category,
      );
      emit(state.copyWith(isLoading: false, destinations: destinations));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    }
  }

  FutureOr<void> _getAllDestinations(
    GetAllDestinations event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(isLoading: true, selectedCategory: CategoryType.all, message: null),
    );
    try {
      final destinations = await service.getDestinations();
      emit(state.copyWith(isLoading: false, destinations: destinations));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    }
  }
}
