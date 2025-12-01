import 'package:easy_meal/data/remote/meal_service.dart';
import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealService service;

  const MealRepositoryImpl({required this.service});

  @override
  Future<List<Meal>> getMealsByCategory(String category) async {
    try {
      final dtos = await service.getMealsByCategory(category);
      return dtos.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      return Future.error('$e');
    }
  }
}