import 'dart:io';

import 'package:expatretail/core.dart';
import 'package:http/http.dart' as http;

class ComplaintRetailService {
  Future<http.Response> getComplaint() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }
    var url = Uri.parse('$baseURL/complaint');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    print(token);
    return response;
  }

  Future<http.Response> postComplaint({
    required int idCustomer,
    required String complaintDate,
    required String productionCode,
    required String description,
    required List<File> files,
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
      Uri.parse('$baseURL/complaint'),
    );
    request.headers.addAll(headers);

    // Add form fields
    request.fields['id_customer'] = idCustomer.toString();
    request.fields['complaint_date'] = complaintDate;
    request.fields['production_code'] = productionCode;
    request.fields['description'] = description;

    // Add files if available
    for (var file in files) {
      var fileStream = await http.MultipartFile.fromPath(
        'files[]', // Assuming your API accepts an array of files
        file.path,
        contentType: MediaType('image', 'jpeg'), // Sesuaikan MIME type
      );
      request.files.add(fileStream);
    }

    // Send the request
    var response = await request.send();

    // Parse the response
    var responseData = await http.Response.fromStream(response);
    print(responseData.body);

    return responseData;
  }

  // Future<http.Response> postComplaint({
  //   required int idCustomer,
  //   required String complaintDate,
  //   required String productionCode,
  //   required String description,
  //   File? file,
  // }) async {
  //   var token = await getToken();
  //   if (token.isEmpty) {
  //     throw Exception('Token is missing');
  //   }

  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //   };

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('$baseURL/complaint'),
  //   );
  //   request.headers.addAll(headers);

  //   // Add form fields
  //   request.fields['id_customer'] = idCustomer.toString();
  //   request.fields['complaint_date'] = complaintDate;
  //   request.fields['production_code'] = productionCode;
  //   request.fields['description'] = description;

  //   // Add file if available
  //   if (file != null) {
  //     var fileStream = await http.MultipartFile.fromPath(
  //       'file',
  //       file.path,
  //       contentType: MediaType('image', 'jpeg'), // Sesuaikan MIME type
  //     );
  //     request.files.add(fileStream);
  //   } else {
  //     print("No file selected.");
  //     throw Exception(
  //         "Image is required."); // Opsional: bisa return atau throw exception
  //   }

  //   // Send the request
  //   var response = await request.send();

  //   // Parse the response
  //   var responseData = await http.Response.fromStream(response);
  //   print(responseData.body);

  //   return responseData;
  // }
}
