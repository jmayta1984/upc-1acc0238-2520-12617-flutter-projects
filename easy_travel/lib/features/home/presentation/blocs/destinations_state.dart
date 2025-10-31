import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';

class DestinationsState {
  final bool isLoading;
  final CategoryType selectedCategory;
  final List<Destination> destinations;
  final String message;

  const DestinationsState({
    this.isLoading = false,
    this.selectedCategory = CategoryType.all,
    this.destinations = const [],
    this.message = '',
  });

  DestinationsState copyWith({
    bool? isLoading,
    CategoryType? selectedCategory,
    List<Destination>? destinations,
    String? message
  }) {
    return DestinationsState(
      isLoading: isLoading ?? this.isLoading,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      destinations: destinations ?? this.destinations,
      message: message ?? this.message
    );
  }
}
