import 'dart:convert';
import 'package:expatretail/core.dart';
import 'package:expatretail/model/retail_model/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileRetailController extends GetxController implements GetxService {
  var listProfile = <ProfileModel>[].obs;
  final profile = ProfileRetailService();
  var isLoading = false.obs;
  late int userId;

  // Method untuk mengatur ID pengguna
  void setUserId(int userid) {
    userId = userid;
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    try {
      var response = await profile.getProfile(userId);
      var responsedecode = jsonDecode(response.body);

      // Check if the 'data' field exists and is not null
      if (responsedecode.containsKey('data') &&
          responsedecode['data'] != null) {
        listProfile.clear();

        // Convert 'data' object to ProfileModel
        ProfileModel data = ProfileModel.fromJson(responsedecode['data']);
        listProfile.add(data);
      } else {
        throw Exception("'data' field is missing or null");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? currentPasswordError;
  String? newPasswordError;
  String? confirmPasswordError;

  String? validatecurrentPassword(String? currentpasswordValue) {
    if (currentpasswordValue == null || currentpasswordValue.isEmpty) {
      return 'Enter your current password';
    } else if (currentpasswordValue.length < 6) {
      return 'Password must have at least 6 characters';
    }
    return null;
  }

  String? validatenewPassword(String? newpasswordValue) {
    if (newpasswordValue == null || newpasswordValue.isEmpty) {
      return 'Enter your new password';
    } else if (newpasswordValue.length < 6) {
      return 'Password must have at least 6 characters';
    }
    return null;
  }

  String? validateconfirmPassword(
      String? confirmpasswordValue, String? newpasswordValue) {
    if (confirmpasswordValue == null || confirmpasswordValue.isEmpty) {
      return 'Enter your confirmation password';
    } else if (confirmpasswordValue.length < 6) {
      return 'Password must have at least 6 characters';
    } else if (confirmpasswordValue != newpasswordValue) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool validateForm() {
    final currentPasswordValue = currentPasswordController.text;
    final newPasswordValue = newPasswordController.text;
    final confirmPasswordValue = confirmPasswordController.text;

    final currentPasswordValidation =
        validatecurrentPassword(currentPasswordValue);
    final newPasswordValidation = validatenewPassword(newPasswordValue);
    final confirmPasswordValidation =
        validateconfirmPassword(confirmPasswordValue, newPasswordValue);

    currentPasswordError = currentPasswordValidation;
    newPasswordError = newPasswordValidation;
    confirmPasswordError = confirmPasswordValidation;

    return currentPasswordValidation == null &&
        newPasswordValidation == null &&
        confirmPasswordValidation == null;
  }

  Future<void> sendChangePassword(BuildContext context) async {
    if (validateForm()) {
      try {
        var response = await profile.postChangePassword(
          currentPassword: currentPasswordController.text,
          newPassword: newPasswordController.text,
          confirmPassword: confirmPasswordController.text,
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          print("Password successfully change!");
          const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success!',
              color: Color.fromRGBO(114, 162, 138, 1),
              message: 'Password successfully changed!',
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (response.statusCode == 400) {
          print("Current password wrong!");
          const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Error!',
              message: 'Current password is incorrect!',
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else {
          print("Failed to change password: ${response.body}");
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Failed!',
              message: 'Failed to change password: ${response.body}',
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      } catch (e) {
        print("Error while changeing password: $e");
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Something went wrong!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }
}
