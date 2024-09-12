import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  String? validateEmail(String? emailValue) {
    if (emailValue == null || emailValue.isEmpty) {
      return 'Masukkan email';
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(emailValue)) {
        return 'Format email tidak valid';
      }
    }
    return null;
  }

  String? validatePassword(String? passwordValue) {
    if (passwordValue == null || passwordValue.isEmpty) {
      return 'Masukkan password';
    } else if (passwordValue.length < 6) {
      return 'Password harus memiliki minimal 6 karakter';
    }
    return null;
  }

  bool validateForm() {
    final emailValue = emailController.text;
    final passwordValue = passwordController.text;

    final emailValidation = validateEmail(emailValue);
    final passwordValidation = validatePassword(passwordValue);

    emailError = emailValidation;
    passwordError = passwordValidation;

    return emailValidation == null && passwordValidation == null;
  }

  // void navigateBasedOnRole(BuildContext context, String roles) {
  //   if (roles == '"customers"') {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const NavigationPage(),
  //       ),
  //     );
  //     // } else if (roles == '"sales"') {
  //     //   Navigator.pushReplacement(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //       builder: (context) => const StartSales(),
  //     //     ),
  //     //   );
  //   } else {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const NavigationPage(),
  //       ),
  //     );
  //   }
  // }

  // bool validateToken(String token) {
  //   final segments = token.split('.');
  //   if (segments.length != 3) {
  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> handleLogin(BuildContext context) async {
  //   if (validateForm()) {
  //     bool loggedIn = await login(); // Tunggu sampai proses login selesai
  //     if (loggedIn) {
  //       SharedPreferences localStorage = await SharedPreferences.getInstance();
  //       var token = localStorage.getString('token');
  //       print('tokenlogin: $token');
  //       if (token != null && validateToken(token)) {
  //         var roles = localStorage.getString('roles');
  //         var user = localStorage.getString('user');
  //         var karyawan = localStorage.getString('karyawan');
  //         var supervisor = localStorage.getString('supervisor');
  //         print('roles: $roles');
  //         print('userprofile: $user');
  //         print('karyawanprofile: $karyawan');
  //         print('supervisorprofile: $supervisor');
  //         if (roles != null && roles.isNotEmpty) {
  //           final snackBar = SnackBar(
  //             elevation: 0,
  //             behavior: SnackBarBehavior.floating,
  //             backgroundColor: Colors.transparent,
  //             content: AwesomeSnackbarContent(
  //               title: 'Info',
  //               color: Color.fromRGBO(114, 162, 138, 1),
  //               message: 'Halaman dashboard akan muncul beberapa saat lagi',
  //               contentType: ContentType.success,
  //             ),
  //           );

  //           ScaffoldMessenger.of(context)
  //             ..hideCurrentSnackBar()
  //             ..showSnackBar(snackBar);

  //           await Future.delayed(const Duration(seconds: 2));
  //           navigateBasedOnRole(context, roles);
  //         } else {
  //           final snackBar = SnackBar(
  //             elevation: 0,
  //             behavior: SnackBarBehavior.floating,
  //             backgroundColor: Colors.transparent,
  //             content: AwesomeSnackbarContent(
  //               title: 'Info',
  //               color: Color.fromRGBO(114, 162, 138, 1),
  //               message:
  //                   'Harap periksa kembali akun yang anda masukan, akun yang anda masukan tidak memiliki role',
  //               contentType: ContentType.failure,
  //             ),
  //           );

  //           ScaffoldMessenger.of(context)
  //             ..hideCurrentSnackBar()
  //             ..showSnackBar(snackBar);
  //         }
  //       }
  //     } else {
  //       final snackBar = SnackBar(
  //         elevation: 0,
  //         behavior: SnackBarBehavior.floating,
  //         backgroundColor: Colors.transparent,
  //         content: AwesomeSnackbarContent(
  //           title: 'Info',
  //           color: Color.fromRGBO(114, 162, 138, 1),
  //           message:
  //               'Harap periksa kembali email dan password, akun yang anda masukan belum terdaftar',
  //           contentType: ContentType.failure,
  //         ),
  //       );

  //       ScaffoldMessenger.of(context)
  //         ..hideCurrentSnackBar()
  //         ..showSnackBar(snackBar);
  //     }
  //   }
  // }

  // Future<bool> login() async {
  //   var data = {
  //     'email': emailController.text,
  //     'password': passwordController.text,
  //   };

  //   var res = await Network().auth(data, '/login/');
  //   var body = json.decode(res.body);
  //   if (res.statusCode == 200) {
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     localStorage.setString('token', body['data']['token']);
  //     localStorage.setString(
  //         'user', json.encode(body['data']['user']['service_user_profile']));
  //     localStorage.setString(
  //         'karyawan', json.encode(body['data']['user']['employee_profile']));
  //     localStorage.setString('supervisor',
  //         json.encode(body['data']['user']['supervisor_profile']));
  //     localStorage.setString(
  //         'roles', json.encode(body['data']['user']['role']));
  //     return true; // Jika login berhasil
  //   } else {
  //     return false; // Jika login gagal
  //   }
  // }

  Future<void> navigateToLogin(BuildContext context) async {
    if (validateForm()) {
      const snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: 'Dashboard page will appear in a few moments',
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
          builder: (context) => const NavigationPage(),
        ),
      );
    }
  }
}
