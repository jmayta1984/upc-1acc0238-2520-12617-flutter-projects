import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';

abstract class DestinationRepository {
  Future<List<Destination>> getDestinationsByCategory(CategoryType category);

  Future<List<Destination>> getAllFavorites();

  Future<Set<int>> getFavoriteIds();

  Future<void> toggleFavorite(Destination destination);
}
