import 'package:expatretail/core.dart';
import 'package:http/http.dart' as http;

class CartRetailService {
  Future<http.Response> getCart() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }
    var url = Uri.parse('$baseURL/cart');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    print(token);
    return response;
  }

  Future<http.Response> postCart({
    required int idCustomer,
    required int idCustomerProduct,
    required int qty,
  }) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseURL/cart'),
    );
    request.headers.addAll(headers);

    // Add form fields
    request.fields['id_customer'] = idCustomer.toString();
    request.fields['id_customer_product'] = idCustomerProduct.toString();
    request.fields['qty'] = qty.toString();

    var response = await request.send();

    // Parse the response
    var responseData = await http.Response.fromStream(response);
    print(responseData.body);

    return responseData;
  }

  Future<http.Response> deleteCart(int idCart) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/cart/$idCart');
    var response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }
}
