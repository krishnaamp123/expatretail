import 'dart:convert';
import 'package:expatretail/core.dart';
import 'package:http/http.dart' as http;

class StockService {
  Future<http.Response> getProfile(int id) async {
    var token = await getToken();
    var url = Uri.parse('$baseURL/profile/$id');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    print(response.body);
    print(token);
    return response;
  }

  Future<http.Response> getStock(int idCustomer) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/customerstock/$idCustomer');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print(response.body);
    print(token);
    return response;
  }

  Future<http.Response> postStockSold({
    required int idCustomer,
    required int idCustomerProduct,
    required int soldQty,
    required int idSupermarket,
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
      'id_customer_product': idCustomerProduct,
      'sold_qty': soldQty,
      'id_supermarket': idSupermarket,
    });

    var url = Uri.parse('$baseURL/customerstock/sold');
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> postStockLost({
    required int idCustomer,
    required int idCustomerProduct,
    required int lostQty,
    required int idSupermarket,
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
      'id_customer_product': idCustomerProduct,
      'lost_qty': lostQty,
      'id_supermarket': idSupermarket,
    });

    var url = Uri.parse('$baseURL/customerstock/lost');
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
