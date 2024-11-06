import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';
import 'package:expatretail/model/supermarket_model/stock_model.dart';

class HistoryStockDetailPage extends StatefulWidget {
  final int idCustomer;
  final String companyName;
  final String customerName;
  final String picName;
  final String picPhone;
  final String address;

  const HistoryStockDetailPage(
      {Key? key,
      required this.idCustomer,
      required this.companyName,
      required this.customerName,
      required this.picName,
      required this.picPhone,
      required this.address})
      : super(key: key);

  @override
  State<HistoryStockDetailPage> createState() => HistoryStockDetailPageState();
}

class HistoryStockDetailPageState extends State<HistoryStockDetailPage> {
  var stokCon = Get.put(StockController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await stokCon.getStock(widget.idCustomer);
    _flattenDetailStocks();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await stokCon.getStock(widget.idCustomer);
    setState(() {});
  }

  // Flatten the list of detail stocks
  List<dynamic> flattenedDetailList = StockController()
      .listStock
      .expand((stock) => stock.detailCustomerStocks ?? [])
      .toList();

  void _flattenDetailStocks() {
    flattenedDetailList = [];
    for (var stock in stokCon.listStock) {
      if (stock.detailCustomerStocks != null) {
        flattenedDetailList.addAll(stock.detailCustomerStocks!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String customerName = widget.customerName;
    String companyName = widget.companyName;
    String picName = widget.picName;
    String picPhone = widget.picPhone;
    String address = widget.address;
    return Scaffold(
      appBar: buildAppBar(context, "STOCK DETAIL"),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  companyName,
                  18,
                  const Color.fromRGBO(114, 162, 138, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                ),
                TextWidget(
                  customerName,
                  16,
                  Colors.white,
                  FontWeight.bold,
                  letterSpace: 0,
                ),
                TextWidget(
                  address,
                  16,
                  Colors.white,
                  FontWeight.normal,
                  letterSpace: 0,
                ),
                Row(
                  children: [
                    const TextWidget(
                      "PIC Name : ",
                      16,
                      Colors.white,
                      FontWeight.normal,
                      letterSpace: 0,
                    ),
                    TextWidget(
                      picName,
                      16,
                      Colors.white,
                      FontWeight.normal,
                      letterSpace: 0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const TextWidget(
                      "PIC Phone : ",
                      16,
                      Colors.white,
                      FontWeight.normal,
                      letterSpace: 0,
                    ),
                    TextWidget(
                      picPhone,
                      16,
                      Colors.white,
                      FontWeight.normal,
                      letterSpace: 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(114, 162, 138, 1),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWidget(
                        "LIST ITEM",
                        18,
                        Colors.white,
                        FontWeight.bold,
                        letterSpace: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          Card(
            color: const Color.fromRGBO(26, 26, 26, 1),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                await _refreshData();
                _flattenDetailStocks(); // Refresh the flattened list
                setState(() {});
              },
              color: const Color.fromRGBO(114, 162, 138, 1),
              child: isDataLoaded
                  ? Obx(
                      () => stokCon.isLoading.value
                          ? const SpinKitWanderingCubes(
                              color: Color.fromRGBO(114, 162, 138, 1),
                              size: 50.0,
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: flattenedDetailList.length,
                              padding: const EdgeInsets.only(bottom: 10),
                              itemExtent: 110,
                              itemBuilder: (BuildContext context, int index) {
                                var detail = flattenedDetailList[index];
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: detailCustomerStocks?.length,
                                  itemBuilder:
                                      (BuildContext context, int detailIndex) {
                                    var detail =
                                        detailCustomerStocks![detailIndex];
                                    return detailCard(
                                        detail.qtyOut!.toInt(),
                                        detail.createdAt.toString(),
                                        detail.customerProduct!.product!
                                            .productName
                                            .toString(),
                                        detail.customerProduct!.product!.image
                                            .toString(),
                                        detail.customerProduct!.product!
                                            .packaging!.packagingName
                                            .toString(),
                                        detail.customerProduct!.product!
                                            .packaging!.weight!
                                            .toInt(),
                                        detail.supermarket!.customerName
                                            .toString(),
                                        detail.type.toString());
                                  },
                                );
                              },
                            ),
                    )
                  : const Center(
                      child: SpinKitWanderingCubes(
                      color: Color.fromRGBO(114, 162, 138, 1),
                      size: 50.0,
                    )),
            ),
          ),

          //Item Holder
        ]),
      ),
    );
  }

  Widget detailCard(
    int qtyOut,
    String createdAt,
    String productName,
    String image,
    String packagingName,
    int weight,
    String supermarketName,
    String type,
  ) {
    final fullImageUrl = '$baseURL/storage/image/$image';
    DateTime parsedDate = DateTime.parse(createdAt);
    String updatedDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
    return Column(
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
                      Row(
                        children: [
                          const Text(
                            "By : ",
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
                            supermarketName,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(114, 162, 138, 1),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Out : ",
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
                            "$qtyOut",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(114, 162, 138, 1),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "[ $type ]",
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
                    ],
                  ),
                ),
                const SizedBox(width: 15),
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
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'unconfirmed':
        return Colors.orange;
      case 'confirmed':
        return const Color.fromRGBO(114, 162, 138, 1);
      default:
        return const Color.fromRGBO(26, 26, 26, 1);
    }
  }
}
