import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:expatretail/core.dart';

class Network {
  final String _url = 'http://10.0.2.2:8000/api';
  // final String _url = 'http://api.salamanderman.my.id/api/v1';

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token') ?? '';
  }

  auth(data, apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    var token = await getToken();
    return await http.get(fullUrl, headers: _setHeadersWithToken(token));
  }

  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Map<String, String> _setHeadersWithToken(String token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
