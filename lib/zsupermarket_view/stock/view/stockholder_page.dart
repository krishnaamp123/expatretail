import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class StockHolderPage extends StatefulWidget {
  final int idCustomer;
  const StockHolderPage({
    Key? key,
    required this.idCustomer,
  }) : super(key: key);

  @override
  State<StockHolderPage> createState() => StockHolderPageState();
}

class StockHolderPageState extends State<StockHolderPage> {
  var stockCon = Get.put(StockController());
  bool isDataLoaded = false;
  int jumlahTotal = 1;

  @override
  void initState() {
    super.initState();
    _refreshData();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await stockCon.getStock(widget.idCustomer);
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await stockCon.getStock(widget.idCustomer);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: const Color.fromRGBO(114, 162, 138, 1),
      child: isDataLoaded
          ? Obx(
              () => stockCon.isLoading.value
                  ? const SpinKitWanderingCubes(
                      color: Color.fromRGBO(114, 162, 138, 1),
                      size: 50.0,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: stockCon.listStock.length,
                      padding: const EdgeInsets.only(bottom: 10),
                      itemExtent: 110,
                      itemBuilder: (BuildContext context, int index) {
                        var stock = stockCon.listStock[index];
                        return stockCard(
                          stock.customer!.id!.toInt(),
                          stock.customerProduct!.id!.toInt(),
                          stock.totalQty!.toInt(),
                          stock.updatedAt.toString(),
                          stock.customerProduct!.product!.productName
                              .toString(),
                          stock.customerProduct!.product!.image.toString(),
                          stock.customerProduct!.product!.descriprtion
                              .toString(),
                          stock.customerProduct!.product!.packaging!
                              .packagingName
                              .toString(),
                          stock.customerProduct!.product!.packaging!.weight!
                              .toInt(),
                        );
                      },
                    ),
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Color.fromRGBO(114, 162, 138, 1),
              size: 50.0,
            )),
    );
  }

  Widget stockCard(
    int idCustomer,
    int idCustomerProduct,
    int totalQty,
    String updatedAt,
    String productName,
    String image,
    String description,
    String packagingName,
    int weight,
  ) {
    final fullImageUrl = '$baseURL/storage/image/$image';

    return InkWell(
      onTap: () {
        _showConfirmationDialog(idCustomer, idCustomerProduct);
      },
      child: Column(
        children: [
          Card(
            color: const Color.fromRGBO(26, 26, 26, 1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      fullImageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'lib/image/logokotak.png',
                          fit: BoxFit.cover,
                          height: 90,
                          width: 90,
                        );
                      },
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
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
                        Row(
                          children: [
                            Text(
                              packagingName,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              " $weight g",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        // const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              "Stock : ",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "$totalQty",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(114, 162, 138, 1),
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.outbound_outlined,
                      size: 30,
                      color: Color.fromRGBO(114, 162, 138, 1),
                    ),
                    onPressed: () {
                      _showConfirmationDialog(idCustomer, idCustomerProduct);
                    },
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              height: 2,
              thickness: 4,
              color: Color.fromRGBO(33, 33, 33, 1),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(int idCustomer, int idCustomerProduct) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Reduce Stock",
            style: TextStyle(
              color: Color.fromRGBO(114, 162, 138, 1),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Double check the input of outgoing stock\nAlso make sure the input is sold or lost",
                style: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              InputQty.int(
                qtyFormProps: const QtyFormProps(
                  enableTyping: true,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(114, 162, 138, 1),
                  ),
                ),
                decoration: const QtyDecorationProps(
                  isBordered: false,
                  borderShape: BorderShapeBtn.circle,
                  width: 15,
                  btnColor: Color.fromRGBO(114, 162, 138, 1),
                ),
                initVal: jumlahTotal,
                minVal: 1,
                maxVal: 50,
                steps: 1,
                onQtyChanged: (value) {
                  setState(() {
                    jumlahTotal = value ?? 1;
                  });
                },
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    stockCon.sendStockLost(
                        context, idCustomer, idCustomerProduct, jumlahTotal);
                    const snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Success!',
                        color: Color.fromRGBO(114, 162, 138, 1),
                        message: 'Thank you, stock successfully reduced!',
                        contentType: ContentType.success,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    _refreshData();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Radius tombol
                    ),
                    backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
                  ),
                  child: const Text(
                    "  Lost  ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    stockCon.sendStockSold(
                        context, idCustomer, idCustomerProduct, jumlahTotal);
                    const snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Success!',
                        color: Color.fromRGBO(114, 162, 138, 1),
                        message: 'Thank you, stock successfully reduced!',
                        contentType: ContentType.success,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    _refreshData();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Radius tombol
                    ),
                    backgroundColor: const Color.fromRGBO(114, 162, 138, 1),
                  ),
                  child: const Text(
                    "  Sold  ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ), // Ukuran teks diperkecil
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
