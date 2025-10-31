import 'dart:async';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DestinationsBloc extends Bloc<DestinationsEvent, DestinationsState> {
  final DestinationService destinationService;
  DestinationsBloc({required this.destinationService})
    : super(DestinationsState()) {
    on<GetDestinationsByCategory>(_getDestinationsByCategory);
    on<GetAllDestinations>(_getAllDestinations);
  }

  FutureOr<void> _getDestinationsByCategory(
    GetDestinationsByCategory event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        selectedCategory: event.category,
        message: null,
      ),
    );
    try {
      final destinations = await destinationService.getDestinations(
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
      state.copyWith(isLoading: true, selectedCategory: 'All', message: null),
    );
    try {
      final destinations = await destinationService.getDestinations();
      emit(state.copyWith(isLoading: false, destinations: destinations));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    }
  }
}
