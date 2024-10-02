import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class OrderPage extends StatefulWidget {
  // final String username;
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarTok(context, "ORDER HISTORY"),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const SingleChildScrollView(
            child: Column(children: [
              Divider(
                height: 2,
                thickness: 4,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
              OrderHolderPage(),
            ]),
          ),
        ),
      ),
    );
  }
}
