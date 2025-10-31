import 'package:easy_travel/features/home/domain/category.dart';

abstract class DestinationsEvent {}

class GetDestinationsByCategory extends DestinationsEvent {
  final CategoryType category;
  GetDestinationsByCategory({required this.category});
}


class GetAllDestinations extends DestinationsEvent {}
