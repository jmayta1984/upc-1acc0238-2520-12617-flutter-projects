import 'dart:async';

import 'package:easy_meal/domain/repositories/category_repository.dart';
import 'package:easy_meal/presentation/blocs/category_event.dart';
import 'package:easy_meal/presentation/blocs/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;
  CategoryBloc({required this.repository}) : super(const CategoryState()) {
    on<GetAllCategories>(_onGetAllCategories);
  }

  FutureOr<void> _onGetAllCategories(
    GetAllCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final categories = await repository.getAllCategories();
      emit(state.copyWith(
        status: Status.success,
        categories: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
