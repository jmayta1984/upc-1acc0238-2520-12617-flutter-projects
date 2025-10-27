import 'package:easy_travel/features/home/domain/destination.dart';

abstract class DestinationsState {}

class DestinationsInitialState extends DestinationsState {}

class DestinationsLoadingState extends DestinationsState {}

class DestinationsSucccessState extends DestinationsState {
  final List<Destination> destinations;
  DestinationsSucccessState({required this.destinations});
}

class DestinationsFailureState extends DestinationsState {
  final String message;
  DestinationsFailureState({required this.message});
}
