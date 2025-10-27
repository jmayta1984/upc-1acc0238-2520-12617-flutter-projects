import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/features/auth/domain/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =
      'https://destinationapp-h4e8dvace3fqffbb.eastus-01.azurewebsites.net/api/users/login';

  Future<User> login(String email, String password) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body);
        return User.fromJson(json);
      }
      return Future.error(response.statusCode);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
