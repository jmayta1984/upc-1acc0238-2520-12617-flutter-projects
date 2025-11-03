import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/core/constants/api_constants.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:http/http.dart' as http;

class DestinationService {
  Future<List<Destination>> getDestinations({
    required CategoryType category,
  }) async {
    final Uri uri = Uri.parse(ApiConstants.baseUrl).replace(
      path: ApiConstants.destinationsEndpoint,
      queryParameters: category == CategoryType.all
          ? null
          : {'type': category.label},
    );

    final response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      List maps = jsonDecode(response.body)['results'];
      return maps.map((json) => Destination.fromJson(json)).toList();
    }
    return [];
  }
}
