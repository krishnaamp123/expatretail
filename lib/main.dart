import 'dart:convert';

import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyExpatApp());
}

class MyExpatApp extends StatelessWidget {
  const MyExpatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(114, 162, 138, 1),
          selectionColor: Color.fromRGBO(114, 162, 138, 1),
          selectionHandleColor: Color.fromRGBO(114, 162, 138, 1),
        ),
      ),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  var role;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
        var userJson = localStorage.getString('user');
        if (userJson != null) {
          Map<String, dynamic> user = jsonDecode(userJson);
          var role = user['role']; // Access the role from the user object
          print('User role: $role');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      // Berdasarkan peran (role) pengguna, tentukan halaman yang akan ditampilkan
      if (role == 'retail') {
        child = const NavigationPage();
        // } else if (role == 'supermarket') {
        // child = StartSupermarket();
      } else {
        child = const LoginPage();
      }
    } else {
      child = const LoginPage();
    }

    return Scaffold(
      body: child,
    );
  }
}
