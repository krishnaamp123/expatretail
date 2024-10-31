import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class HistoryStockPage extends StatefulWidget {
  const HistoryStockPage({Key? key}) : super(key: key);

  @override
  State<HistoryStockPage> createState() => HistoryStockPageState();
}

class HistoryStockPageState extends State<HistoryStockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarTok(context, "STOCK HISTORY"),
      backgroundColor: Colors.black,
      body: const SafeArea(
        child: Expanded(
          // Menggunakan Expanded di sini
          child: HistoryStockHolderPage(),
        ),
      ),
    );
  }
}
