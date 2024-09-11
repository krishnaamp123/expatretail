import 'package:expatretail/landing/view/landing_page.dart';
import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  var roles;

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
        roles = localStorage.getString('roles');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      // Berdasarkan peran (role) pengguna, tentukan halaman yang akan ditampilkan
      if (roles == '"customers"') {
        child = const Navigation();
        // } else if (roles == '"sales"') {
        //   child = StartSales();
      } else {
        // Jika peran tidak sesuai, bisa menampilkan halaman default atau splash screen
        child = const LandingPage();
      }
    } else {
      child = const LandingPage();
    }

    return Scaffold(
      body: child,
    );
  }
}
