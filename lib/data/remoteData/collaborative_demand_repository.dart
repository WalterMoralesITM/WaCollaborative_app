import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wa_collaborative/domain/entities/collaborative_demand_sales.dart';
import 'package:wa_collaborative/domain/entities/report_assert.dart';
import '../../appconfig.dart';
import '../../domain/entities/collaborative_demand_detail.dart';
import '../../domain/entities/collaborative_demand_grouped.dart';


class CollaborativeDemandRepository {

  CollaborativeDemandRepository();


  Future<List<ReportAssert>> getDetailHistoryAssertAsync(int collaborativeDemandId) async {

    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/CollaborativeDemand/GetDetailHistoryAssertAsync/${collaborativeDemandId}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearerToken = prefs.getString('token');
    late List<ReportAssert> reportAssert;

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
      try {
        List<Map<String, dynamic>> responseData = parseResponse(response.body);
        //final List<Map<String, dynamic>> responseData = json.decode(response.body);
        reportAssert = responseData.map((item) => ReportAssert.fromJson(item)).toList();
      }
      catch(e){
        print(e);
      }
      return reportAssert;

    } else {
      throw Exception('Falló la petición: ${response.statusCode}');
    }
  }

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
      try {
        List<Map<String, dynamic>> responseData = parseResponse(response.body);
        //final List<Map<String, dynamic>> responseData = json.decode(response.body);
        collaborativeDemandGrouped = responseData.map((item) => CollaborativeDemandGrouped.fromJson(item)).toList();
      }
      catch(e){
        print(e);
      }
      return collaborativeDemandGrouped;

    } else {
      throw Exception('Falló la petición: ${response.statusCode}');
    }
  }

  Future<List<CollaborativeDemandGrouped>> getCollaborativeDemandHistory() async {

    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/CollaborativeDemand/GetAllGroupedHistoryAsync');
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
      try {
        List<Map<String, dynamic>> responseData = parseResponse(response.body);
        //final List<Map<String, dynamic>> responseData = json.decode(response.body);
        collaborativeDemandGrouped = responseData.map((item) => CollaborativeDemandGrouped.fromJson(item)).toList();
      }
      catch(e){
        print(e);
      }
      return collaborativeDemandGrouped;

    } else {
      throw Exception('Falló la petición: ${response.statusCode}');
    }
  }

  List<Map<String, dynamic>> parseResponse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed;
  }

  Future<List<CollaborativeDemandDetail>> getCollaborativeDemandDetail(int collaborativeDemandId) async {

    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/CollaborativeDemand/GetByCollaborativeDemandIdAsync/$collaborativeDemandId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearerToken = prefs.getString('token');
    late List<CollaborativeDemandDetail> collaborativeDemandDetail;

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

      collaborativeDemandDetail = responseData.map((item) => CollaborativeDemandDetail.fromJson(item)).toList();
      return collaborativeDemandDetail;
    } else {
      throw Exception('Falló la petición: ${response.statusCode}');
    }
  }

  Future<String?> updateCollaborativeDemandDetail(List<CollaborativeDemandDetail> collaborations) async {

    try{
      final Uri url = Uri.parse('${AppConfig.baseUrl}/api/CollaborativeDemandComponentsDetail/SaveCollaborationAsync');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var bearerToken = prefs.getString('token');
      List<Map<String, dynamic>> collaborationJsonList = collaborations.map((item) => item.toJson()).toList();
      var collaborationJsonEncode = jsonEncode(collaborationJsonList);
      final response = await http.put(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept':'/*/',
            'Accept-Encoding':'gzip, deflate, br',
            'Connection':'keep-alive',
            'Authorization': 'Bearer $bearerToken',
          },
          body: collaborationJsonEncode
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
      } else {
        throw Exception('Failed to sign in: ${response.statusCode}');
      }
    }
    catch(e){

    }

  }

  Future<List<CollaborativeDemandSales>> getCollaborativeDemandSales(int collaborativeDemandId) async {

    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/CollaborativeDemand/salesByDemandId/$collaborativeDemandId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearerToken = prefs.getString('token');
    late List<CollaborativeDemandSales> collaborativeDemandSales;

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
      try {
        List<Map<String, dynamic>> responseData = parseResponse(response.body);
        //final List<Map<String, dynamic>> responseData = json.decode(response.body);
        collaborativeDemandSales = responseData.map((item) => CollaborativeDemandSales.fromJson(item)).toList();
      }
      catch(e){
        print(e);
      }
      return collaborativeDemandSales;

    } else {
      throw Exception('Falló la petición: ${response.statusCode}');
    }
  }
}
