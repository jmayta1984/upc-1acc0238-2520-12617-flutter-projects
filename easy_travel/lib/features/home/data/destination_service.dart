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
    try {
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

      if (response.statusCode == HttpStatus.notFound) {
        throw HttpException('No destinations found (404)');
      }

      if (response.statusCode >= 500) {
        throw HttpException('Server error ${response.statusCode}');
      }

      throw HttpException('Unexpected HTTP Status: ${response.statusCode}');
    } on SocketException {
      throw const SocketException('Failed to establish network connection');
    } on FormatException catch (e) {
      throw FormatException('Failed to parse response: $e');
    } catch (e) {
      throw Exception('Unexpected error while fetching destinations: $e');
    }
  }
}
