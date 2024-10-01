import 'package:expatretail/core.dart';
import 'package:http/http.dart' as http;

class CartService {
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
}
