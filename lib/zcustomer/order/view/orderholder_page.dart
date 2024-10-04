import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class OrderHolderPage extends StatefulWidget {
  const OrderHolderPage({super.key});

  @override
  State<OrderHolderPage> createState() => _OrderHolderState();
}

class _OrderHolderState extends State<OrderHolderPage> {
  var orderCon = Get.put(OrderController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    await orderCon.getOrder();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await orderCon.getOrder();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? SingleChildScrollView(
              child: SizedBox(
                height: 700,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderCon.listOrder.length,
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  itemExtent: 100,
                  itemBuilder: (BuildContext context, int index) {
                    var order = orderCon.listOrder[index];
                    return orderCard(order.id!.toInt(),
                        order.totalPrice!.toInt(), order.createdAt.toString());
                  },
                ),
              ),
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Color.fromRGBO(114, 162, 138, 1),
              size: 50.0,
            )),
    );
  }

  Widget orderCard(int id, int totalPrice, String tanggalBuat) {
    String formattedtotalprice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(totalPrice);
    DateTime parsedDate = DateTime.parse(tanggalBuat);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return Column(
      children: [
        Card(
          color: const Color.fromRGBO(26, 26, 26, 1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: 90,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order $id",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formattedtotalprice,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(114, 162, 138, 1),
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
