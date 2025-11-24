import 'package:easy_meal/data/remote/category_service.dart';
import 'package:easy_meal/domain/models/category.dart';
import 'package:easy_meal/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService service;

  const CategoryRepositoryImpl({required this.service});
  @override
  Future<List<Category>> getAllCategories() async {
    try {
      final dtos = await service.getAllCategories();
      return dtos.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      return Future.error('$e');
    }
  }
}
