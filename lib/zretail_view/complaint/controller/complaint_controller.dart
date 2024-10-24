import 'dart:convert';
import 'dart:io';

import 'package:expatretail/core.dart';
import 'package:expatretail/model/retail_model/complaint_model.dart';
import 'package:flutter/material.dart';

class ComplaintRetailController extends GetxController implements GetxService {
  var listComplaint = <ComplaintModel>[].obs;
  final complaint = ComplaintRetailService();
  var isLoading = false.obs;

  Future<void> getComplaint() async {
    isLoading.value = true;
    var response = await complaint.getComplaint();

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var responsedecode = jsonDecode(response.body);
    listComplaint.clear();
    for (var i = 0; i < responsedecode['data'].length; i++) {
      ComplaintModel data = ComplaintModel.fromJson(responsedecode['data'][i]);
      listComplaint.add(data);
    }

    isLoading.value = false;
  }

  Future<void> sendComplaint(
      int id, List<File> profileImages, DateTime selectedDate) async {
    if (validateForm()) {
      try {
        var response = await complaint.postComplaint(
          idCustomer: id,
          complaintDate:
              "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
          productionCode: kodeproduksiController.text,
          description: descriptionController.text,
          files: profileImages, // Pass the list of images
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          print("Complaint successfully sent!");
        } else {
          print("Failed to send complaint: ${response.body}");
        }
      } catch (e) {
        print("Error while sending complaint: $e");
      }
    }
  }

  // Future<void> sendComplaint(
  //     int id, File profileImage, DateTime selectedDate) async {
  //   if (validateForm()) {
  //     try {
  //       var response = await complaint.postComplaint(
  //         idCustomer: id,
  //         complaintDate:
  //             "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
  //         productionCode: kodeproduksiController.text,
  //         description: descriptionController.text,
  //         file: profileImage,
  //       );

  //       print('Response status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         print("Complaint successfully sent!");
  //       } else {
  //         print("Failed to send complaint: ${response.body}");
  //       }
  //     } catch (e) {
  //       print("Error while sending complaint: $e");
  //     }
  //   }
  // }

  final TextEditingController kodeproduksiController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? kodeproduksiError;
  String? descriptionError;

  String? validateKodeProduksi(String? kodeproduksiValue) {
    if (kodeproduksiValue == null || kodeproduksiValue.isEmpty) {
      return 'Enter your production code';
    }
    return null;
  }

  String? validateDescription(String? descriptionValue) {
    if (descriptionValue == null || descriptionValue.isEmpty) {
      return 'Enter your complaint';
    }
    return null;
  }

  bool validateForm() {
    final kodeproduksiValue = kodeproduksiController.text;
    final descriptionValue = descriptionController.text;

    final kodeproduksiValidation = validateKodeProduksi(kodeproduksiValue);
    final descriptionValidation = validateDescription(descriptionValue);

    kodeproduksiError = kodeproduksiValidation;
    descriptionError = descriptionValidation;

    return kodeproduksiValidation == null && descriptionValidation == null;
  }
}
