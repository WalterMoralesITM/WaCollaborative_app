import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../appconfig.dart';
import '../models/chart.dart';

class ChartRepository{

  ChartRepository();

  Future<void> getSalesData() async {
    final Uri apiUrl = Uri.parse('${AppConfig.baseUrl}/api/CollaborativeDemand/Sales?ShippingPointId=2&ProductId=2&ReportType=LastTwoYears');
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
        //final Map<String, dynamic> chartData = json.decode(response.body);
        List<dynamic> data = json.decode(response.body);

        //prefs.setString('userData', json.encode(chartData));
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      //print('Error: $error');
      throw Exception('Failed to connect to the server');
    }
  }

}