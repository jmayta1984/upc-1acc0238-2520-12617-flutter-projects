import 'package:easy_travel/features/home/domain/category.dart';

abstract class HomeEvent {}

class GetDestinationsByCategory extends HomeEvent {
  final CategoryType category;
  GetDestinationsByCategory({required this.category});
}
