import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

AppBar buildAppBarCart(BuildContext context, String title) {
  return AppBar(
    iconTheme:
        const IconThemeData(size: 30, color: Color.fromRGBO(162, 162, 181, 1)),
    leading: Padding(
      padding: const EdgeInsets.only(left: 16.0),
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
    title: Text(
      title, // Title is dynamic
      style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
          color: Colors.white),
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
            Icons.shopping_cart_outlined, // Cart icon
            size: 28,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KeranjangPage(),
              ),
            );
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
        backgroundColor: Colors.black,
        title: const Text(
          "Confirmation",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to logout?",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog tanpa logout
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              logout(context);
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                color: Color.fromRGBO(114, 162, 138, 1),
              ),
            ),
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
