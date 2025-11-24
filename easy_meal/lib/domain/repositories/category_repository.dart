import 'package:easy_meal/domain/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
}