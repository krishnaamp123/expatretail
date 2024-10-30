import 'package:expatretail/core.dart';
import 'package:http/http.dart' as http;

class ProfileRetailSuperService {
  Future<http.Response> getProfileRetail() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/profileretail');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print(response.body);
    print(token);
    return response;
  }
}
