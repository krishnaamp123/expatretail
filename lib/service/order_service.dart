import 'dart:convert';
import 'package:expatretail/core.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<http.Response> getOrder() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/order');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print(response.body);
    print(token);
    return response;
  }

  Future<http.Response> postOrder({
    required int idCustomer,
    required List<Map<String, dynamic>> details,
  }) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = jsonEncode({
      'id_customer': idCustomer,
      'details': details,
    });

    var url = Uri.parse('$baseURL/order');
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }
}
