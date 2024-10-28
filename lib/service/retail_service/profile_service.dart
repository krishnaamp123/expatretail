import 'dart:convert';

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

  Future<http.Response> postChangePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
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
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    });

    var url = Uri.parse('$baseURL/auth/changePassword');
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
