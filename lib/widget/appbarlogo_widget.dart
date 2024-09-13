import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

AppBar buildAppBarLogo(BuildContext context) {
  return AppBar(
    title: Image.asset(
      'lib/image/expatlogo.png',
      height: 60,
      width: 60,
    ),
    centerTitle: true,
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    // Add cart icon to the right
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(
          icon: const Icon(
            Icons.logout, // Cart icon
            size: 28,
            color: Colors.white,
          ),
          onPressed: () {
            _showLogoutConfirmationDialog(context);
          },
        ),
      ),
    ],
  );
}

Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Anda yakin ingin logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog tanpa logout
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog sebelum logout
              logout(context); // Panggil fungsi logout
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}

Future<void> logout(BuildContext context) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  localStorage.remove('token');
  localStorage.remove('user');
  print('Token setelah logout: ${localStorage.getString('token')}');
  print('User setelah logout: ${localStorage.getString('user')}');

  // Navigasi ke halaman login atau halaman awal aplikasi setelah logout
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}
