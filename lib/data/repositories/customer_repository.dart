import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../appconfig.dart';
import '../../domain/entities/customer_basic_contact.dart';

class CustomerRepository{
  CustomerRepository();

  Future<List<CustomerBasicContact>> getCustomerByUserAsync() async {

    final Uri url = Uri.parse('${AppConfig.baseUrl}/api/Customers/getCustomerByUserAsync');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bearerToken = prefs.getString('token');
    late List<CustomerBasicContact> customerBasicContact;

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
        customerBasicContact = responseData.map((item) => CustomerBasicContact.fromJson(item)).toList();
      }
      catch(e){
        print(e);
      }
      return customerBasicContact;

    } else {
      throw Exception('Falló la petición: ${response.statusCode}');
    }
  }

  List<Map<String, dynamic>> parseResponse(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed;
  }
}