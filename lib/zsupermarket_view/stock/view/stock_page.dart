import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class StockPage extends StatefulWidget {
  final int idCustomer;
  final String customerName;
  const StockPage(
      {Key? key, required this.idCustomer, required this.customerName})
      : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int idCustomer = widget.idCustomer;
    String customerName = widget.customerName;
    return Scaffold(
      appBar: buildAppBar(context, "STOCK"),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(114, 162, 138, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          customerName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            // Menggunakan Expanded di sini
            child: Card(
                color: const Color.fromRGBO(26, 26, 26, 1),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: StockHolderPage(
                  idCustomer: idCustomer,
                )),
          ),

          //Item Holder
        ]),
      ),
    );
  }
}
