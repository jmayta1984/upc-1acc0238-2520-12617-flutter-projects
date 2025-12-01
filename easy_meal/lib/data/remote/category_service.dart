import 'dart:convert';
import 'dart:io';

import 'package:easy_meal/core/constants/api_constants.dart';
import 'package:easy_meal/data/models/category_dto.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<CategoryDto>> getAllCategories() async {
    final Uri uri = Uri.parse(
      "${ApiConstants.baseUrl}/${ApiConstants.categoryEndpoint}",
    );
    try {
      final response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = jsonDecode(response.body);
        final List jsons = jsonResponse['categories'];
        return jsons.map((json) => CategoryDto.fromJson(json)).toList();
      }
      return Future.error('Failed to load categories: ${response.statusCode}');
    } catch (e) {
      return Future.error('Failed to load categories: $e');
    }
  }
}
