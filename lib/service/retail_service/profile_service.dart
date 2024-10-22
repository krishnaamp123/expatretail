import 'package:expatretail/core.dart';
import 'package:http/http.dart' as http;

class ProfileRetailService {
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
}
