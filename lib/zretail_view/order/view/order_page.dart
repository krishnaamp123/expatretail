import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class OrderRetailPage extends StatefulWidget {
  const OrderRetailPage({Key? key}) : super(key: key);

  @override
  State<OrderRetailPage> createState() => OrderRetailPageState();
}

class OrderRetailPageState extends State<OrderRetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarTok(context, "ORDER HISTORY"),
      backgroundColor: Colors.black,
      body: const SafeArea(
        child: Column(
          children: [
            Divider(
              height: 2,
              thickness: 4,
              color: Color.fromRGBO(33, 33, 33, 1),
            ),
            SizedBox(height: 10),
            Expanded(
              // Menggunakan Expanded di sini
              child: OrderRetailHolderPage(),
            ),
          ],
        ),
      ),
    );
  }
}
