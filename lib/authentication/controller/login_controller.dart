import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;

  String? validateUsername(String? usernameValue) {
    if (usernameValue == null || usernameValue.isEmpty) {
      return 'Enter your username';
    }
    return null;
  }

  String? validatePassword(String? passwordValue) {
    if (passwordValue == null || passwordValue.isEmpty) {
      return 'Enter your password';
    } else if (passwordValue.length < 6) {
      return 'Password must have at least 6 characters';
    }
    return null;
  }

  bool validateForm() {
    final usernameValue = usernameController.text;
    final passwordValue = passwordController.text;

    final usernameValidation = validateUsername(usernameValue);
    final passwordValidation = validatePassword(passwordValue);

    usernameError = usernameValidation;
    passwordError = passwordValidation;

    return usernameValidation == null && passwordValidation == null;
  }

  void navigateBasedOnRole(BuildContext context, String role) {
    if (role == 'retail') {
      navigateToRetail(context);
    } else if (role == 'supermarket') {
      navigateToSupermarket(context);
    } else if (role == 'admin') {
      const snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Failure!',
          message: 'Admin were using the web app!',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  bool validateToken(String token) {
    final segments = token.split('.');
    if (segments.length != 3) {
      return false;
    }
    return true;
  }

  Future<void> handleLogin(BuildContext context) async {
    if (validateForm()) {
      bool loggedIn = await login();
      if (loggedIn) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.getString('token');
        print('tokenlogin: $token');
        if (token != null && validateToken(token)) {
          var userJson = localStorage.getString('user');
          if (userJson != null) {
            Map<String, dynamic> user = jsonDecode(userJson);
            var role = user['role']; // Access the role from the user object
            print('User role: $role');
            if (role != null && role.isNotEmpty) {
              navigateBasedOnRole(context, role);
            } else {
              const snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Info',
                  message: 'The account entered does not have a role.',
                  contentType: ContentType.failure,
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          }
        }
      } else {
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Failure!',
            message: 'The entered account is not registered!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  Future<bool> login() async {
    var data = {
      'username': usernameController.text,
      'password': passwordController.text,
    };

    var res = await Network().auth(data, '/auth/login');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['access_token']);
      localStorage.setString('user', json.encode(body['user']));
      return true; // Jika login berhasil
    } else {
      return false; // Jika login gagal
    }
  }

  Future<void> navigateToRetail(BuildContext context) async {
    const snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success!',
        message: 'Retail page appear in a few moments!',
        color: Color.fromRGBO(114, 162, 138, 1),
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NavigationPage(initialIndex: 0),
      ),
    );
  }

  Future<void> navigateToSupermarket(BuildContext context) async {
    const snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success!',
        message: 'Supermarket page appear in a few moments!',
        color: Color.fromRGBO(114, 162, 138, 1),
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NavigationSuperPage(initialIndex: 0),
      ),
    );
  }
}
