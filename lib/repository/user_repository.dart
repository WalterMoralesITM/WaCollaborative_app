import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../appconfig.dart';
import '../models/user.dart';


class UserRepository{

  UserRepository();

  Future<void> fetchAndStoreUserData() async {
    final Uri apiUrl = Uri.parse('${AppConfig.baseUrl}/api/Accounts');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearerToken = prefs.getString('token');

    try {
      final response = await http.get(
        apiUrl,
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);

        prefs.setString('userData', json.encode(userData));
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      //print('Error: $error');
      throw Exception('Failed to connect to the server');
    }
  }

// Función para obtener los datos almacenados temporalmente en la memoria
  Future<Map<String, dynamic>> getStoredUserData(bool forceGetFromDataBase) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');


    if (userDataString != null && !forceGetFromDataBase) {
      return json.decode(userDataString);
    } else {
      await fetchAndStoreUserData();
      userDataString = prefs.getString('userData');
      return json.decode(userDataString.toString());
    }
  }

  Future<String?> updateUser(User user) async {

    try{
      final Uri url = Uri.parse('${AppConfig.baseUrl}/api/Accounts');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var bearerToken = prefs.getString('token');
      Map<String, dynamic> userJson = user.toJson();
      var userJsonEncode = jsonEncode(userJson);
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept':'/*/',
          'Accept-Encoding':'gzip, deflate, br',
          'Connection':'keep-alive',
          'Authorization': 'Bearer $bearerToken',
        },
        body: userJsonEncode
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
      } else {
        throw Exception('Failed to sign in: ${response.statusCode}');
      }
    }
    catch(e){
      print("error $e.");
    }

  }

}