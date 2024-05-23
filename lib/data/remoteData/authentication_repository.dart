import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../appconfig.dart';


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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      String token = responseData['token'];
      prefs.setString('token', token);
      return token;
    } else {
      throw Exception('Failed to sign in: ${response.statusCode}');
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
