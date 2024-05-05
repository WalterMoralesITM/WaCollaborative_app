import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../appconfig.dart';


class UserRepository{

  UserRepository();

  Future<void> fetchAndStoreUserData(String bearerToken) async {
    final Uri apiUrl = Uri.parse('${AppConfig.baseUrl}/api/Accounts');

    try {
      // Realizar la solicitud HTTP con el token de autorización en el encabezado
      final response = await http.get(
        apiUrl,
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );

      // Verificar si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        // Decodificar el JSON de respuesta
        final Map<String, dynamic> userData = json.decode(response.body);

        // Almacenar los datos en la memoria local usando SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userData', json.encode(userData));
      } else {
        // Manejar errores de solicitud
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      // Manejar errores de conexión
      print('Error: $error');
      throw Exception('Failed to connect to the server');
    }
  }

// Función para obtener los datos almacenados temporalmente en la memoria
  Future<Map<String, dynamic>> getStoredUserData(String bearerToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return json.decode(userDataString);
    } else {
      await fetchAndStoreUserData(bearerToken);
      userDataString = prefs.getString('userData');
      return json.decode(userDataString.toString());
    }
  }
}