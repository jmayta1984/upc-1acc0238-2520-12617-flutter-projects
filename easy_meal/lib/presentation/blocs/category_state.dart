import 'package:easy_meal/domain/models/category.dart';

enum Status { initial, loading, success, failure }

class CategoryState {
  final Status status;
  final List<Category> categories;
  final String? message;

  const CategoryState({
    this.status = Status.initial,
    this.categories = const [],
    this.message,
  });

  CategoryState copyWith({
    Status? status,
    List<Category>? categories,
    String? message,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      message: message ?? this.message,
    );
  }
}
