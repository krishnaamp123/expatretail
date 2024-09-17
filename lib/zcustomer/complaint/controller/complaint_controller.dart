import 'package:flutter/material.dart';

class ComplaintController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController kodeproduksiController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? kodeproduksiError;
  String? descriptionError;
  String? passwordError;

  String? validateKodeProduksi(String? kodeproduksiValue) {
    if (kodeproduksiValue == null || kodeproduksiValue.isEmpty) {
      return 'Enter your production code';
    } else if (kodeproduksiValue.length < 6) {
      return 'Kode produksi harus memiliki minimal 6 karakter';
    }
    return null;
  }

  String? validateDescription(String? descriptionValue) {
    if (descriptionValue == null || descriptionValue.isEmpty) {
      return 'Enter your complaint';
    } else if (descriptionValue.length < 6) {
      return 'Kode produksi harus memiliki minimal 6 karakter';
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
