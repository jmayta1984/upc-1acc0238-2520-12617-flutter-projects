abstract class DestinationsEvent {}

class GetDestinationsByCategory extends DestinationsEvent {
  final String category;
  GetDestinationsByCategory({required this.category});
}


class GetAllDestinations extends DestinationsEvent {}
