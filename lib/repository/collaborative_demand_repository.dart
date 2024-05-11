import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../appconfig.dart';
import '../models/collaborative_demand_grouped.dart';


class CollaborativeDemandRepository {

  CollaborativeDemandRepository();

  Future<List<CollaborativeDemandGrouped>> getCollaborativeDemand() async {

    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/CollaborativeDemand/GetAllGroupedAsync');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearerToken = prefs.getString('token');
    late List<CollaborativeDemandGrouped> collaborativeDemandGrouped;

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept':'/*/',
        'Accept-Encoding':'gzip, deflate, br',
        'Connection':'keep-alive',
        'Authorization': 'Bearer $bearerToken',
      }
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> responseData = parseResponse(response.body);
      //final List<Map<String, dynamic>> responseData = json.decode(response.body);
      collaborativeDemandGrouped = responseData.map((item) => CollaborativeDemandGrouped.fromJson(item)).toList();
      return collaborativeDemandGrouped;
    } else {
      throw Exception('Falló la petición: ${response.statusCode}');
    }
  }

  List<Map<String, dynamic>> parseResponse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed;
  }

}
