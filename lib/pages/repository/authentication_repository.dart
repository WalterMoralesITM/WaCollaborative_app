import 'dart:convert';
import 'package:http/http.dart' as http;

import '../appconfig.dart';

class AuthRepository {

  AuthRepository();

  Future<String?> signIn(String email, String password) async {
    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/Accounts/Login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['token'];
    } else {
      throw Exception('Failed to sign in: ${response.statusCode}');
    }
  }
}
