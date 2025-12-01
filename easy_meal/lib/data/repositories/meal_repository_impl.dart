import 'package:easy_meal/data/local/meal_dao.dart';
import 'package:easy_meal/data/models/meal_entity.dart';
import 'package:easy_meal/data/remote/meal_service.dart';
import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealService service;
  final MealDao dao;
  const MealRepositoryImpl({required this.service, required this.dao});

  @override
  Future<List<Meal>> getMealsByCategory(String category) async {
    try {
      final dtos = await service.getMealsByCategory(category);
      final favoriteIds = await dao.getFavoriteMealIds();
      return dtos
          .map(
            (dto) => dto.toDomain().copyWith(
              isFavorite: favoriteIds.contains(dto.id),
            ),
          )
          .toList();
    } catch (e) {
      return Future.error('$e');
    }
  }

  @override
  Future<void> toggleMealFavorite(Meal meal) {
    if (meal.isFavorite) {
      return dao.deleteFavorite(meal.id);
    } else {
      return dao.insertFavorite(MealEntity.fromDomain(meal));
    }
  }
}
