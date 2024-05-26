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

  Future<String> recoverPasswordToken(String email) async {
    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/Accounts/RecoverPasswordToken');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['token'];
    } else {
      throw Exception('Failed to recover password token: ${response.statusCode} ${response.body}');
    }
  }

  Future<void> resetPassword(String email, String token, String password) async {
    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/Accounts/ResetPassword');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'token': token,
        'password': password,
        'confirmPassword': password,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to reset password: ${response.statusCode} ${response.body}');
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearerToken = prefs.getString('token');

    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/Accounts/changePassword');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      },
      body: jsonEncode({
        'CurrentPassword': currentPassword,
        'NewPassword': newPassword,
        'Confirm': newPassword, // Assuming the confirmation is the same as the new password
      }),
    );

    if (response.statusCode != 204) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw Exception('Failed to change password: ${responseData['message']}');
    }
  }

}
