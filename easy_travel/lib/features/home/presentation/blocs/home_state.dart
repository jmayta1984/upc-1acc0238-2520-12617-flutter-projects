import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/presentation/models/destination_ui.dart';

class HomeState {
  final Status status;
  final CategoryType selectedCategory;
  final List<DestinationUi> destinations;
  final String? message;

  const HomeState({
    this.status = Status.initial,
    this.selectedCategory = CategoryType.all,
    this.destinations = const [],
    this.message,
  });

  HomeState copyWith({
    Status? status,
    CategoryType? selectedCategory,
    List<DestinationUi>? destinations,
    String? message
  }) {
    return HomeState(
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      destinations: destinations ?? this.destinations,
      message: message ?? this.message
    );
  }
}
