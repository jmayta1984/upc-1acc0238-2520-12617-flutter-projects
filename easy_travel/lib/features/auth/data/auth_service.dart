import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/core/constants/api_constants.dart';
import 'package:easy_travel/features/auth/domain/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<User> login(String email, String password) async {
    try {
      final Uri uri = Uri.parse(ApiConstants.baseUrl);
      final http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        return User.fromJson(json);
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
