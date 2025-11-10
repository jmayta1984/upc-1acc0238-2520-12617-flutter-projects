import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class GetDestinationsByCategory extends HomeEvent {
  final CategoryType category;
  const GetDestinationsByCategory({required this.category});
}

class ToggleFavorite extends HomeEvent {
  final Destination destination;
  const ToggleFavorite({required this.destination});
}
