import 'package:easy_meal/domain/models/category.dart';

class CategoryDto {
  final String id;
  final String name;
  final String description;
  final String posterPath;

  const CategoryDto({
    required this.id,
    required this.name,
    required this.description,
    required this.posterPath,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['idCategory'],
      name: json['strCategory'],
      description: json['strCategoryDescription'],
      posterPath: json['strCategoryThumb'],
    );
  }

  Category toDomain() {
    return Category(
      id: id,
      name: name,
      description: description,
      posterPath: posterPath,
    );
  }

}

