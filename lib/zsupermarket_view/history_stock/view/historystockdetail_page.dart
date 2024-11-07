import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

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
  TextEditingController dateController = TextEditingController();
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
  List<dynamic> flattenedDetailList = [];

  void _flattenDetailStocks() {
    flattenedDetailList.clear(); // Ensure it's emptied before adding new items.
    for (var stock in stokCon.listStock) {
      if (stock.detailCustomerStocks != null) {
        flattenedDetailList.addAll(stock.detailCustomerStocks!);
      }
    }
    // Urutkan flattenedDetailList berdasarkan tanggal terbaru
    flattenedDetailList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  void _filterByDate(String dateTime) {
    setState(() {
      flattenedDetailList = stokCon.listStock
          .expand((stock) => stock.detailCustomerStocks ?? [])
          .where((detail) {
        DateTime createdAtDateTime = DateTime.parse(detail.createdAt);
        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm').format(createdAtDateTime);

        return formattedDate.startsWith(dateTime);
      }).toList();
    });
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
      body: RefreshIndicator(
        onRefresh: () async {
          await _refreshData();
          _flattenDetailStocks();
          setState(() {});
        },
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
                    Expanded(
                      child: TextWidget(
                        picName,
                        16,
                        Colors.white,
                        FontWeight.normal,
                        letterSpace: 0,
                      ),
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
          const SizedBox(height: 5),
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
                        "RECENT OUTSTOCK",
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
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: dateController,
              onChanged: (value) {
                _filterByDate(value);
              },
              style: const TextStyle(
                color: Colors.white, // Text color
                fontSize: 16, // Text size
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(26, 26, 26, 1),
                hintText: "Search Date",
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(114, 162, 138, 1),
                  fontSize: 16, // Hint text size
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(114, 162, 138, 1), // Icon color
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none, // Removes the border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(26, 26, 26, 1),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(
                        114, 162, 138, 1), // Border color when focused
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: isDataLoaded
                ? Obx(
                    () => stokCon.isLoading.value
                        ? const SpinKitWanderingCubes(
                            color: Color.fromRGBO(114, 162, 138, 1),
                            size: 50.0,
                          )
                        : Card(
                            color: const Color.fromRGBO(26, 26, 26, 1),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: flattenedDetailList.length,
                                padding: const EdgeInsets.only(bottom: 10),
                                itemExtent: 120,
                                itemBuilder: (BuildContext context, int index) {
                                  var detail = flattenedDetailList[index];
                                  return detailCard(
                                      detail.qtyOut!.toInt(),
                                      detail.createdAt.toString(),
                                      detail
                                          .customerProduct!.product!.productName
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
                              ),
                            ),
                          ),
                  )
                : const Center(
                    child: SpinKitWanderingCubes(
                    color: Color.fromRGBO(114, 162, 138, 1),
                    size: 50.0,
                  )),
          ),
        ]),

        //Item Holder
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
    Color typeColor = _getTypeColor(type);
    final fullImageUrl = '$baseURL/storage/image/$image';
    DateTime parsedDate = DateTime.parse(createdAt);
    String createdDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
    return Column(
      children: [
        Card(
          color: const Color.fromRGBO(26, 26, 26, 1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: 110,
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
                          Expanded(
                            child: Text(
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
                          ),
                          Expanded(
                            child: Text(
                              supermarketName,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(114, 162, 138, 1),
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        createdDate,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                          ),
                          Text(
                            "$qtyOut",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(114, 162, 138, 1),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const Text(
                            " | ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            type,
                            style: TextStyle(
                              fontSize: 15,
                              color: typeColor,
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

  Color _getTypeColor(String type) {
    switch (type) {
      case 'lost':
        return Colors.orange;
      case 'sold':
        return const Color.fromRGBO(114, 162, 138, 1);
      default:
        return const Color.fromRGBO(26, 26, 26, 1);
    }
  }
}
