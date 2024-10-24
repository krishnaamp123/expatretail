import 'package:expatretail/model/retail_model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class OrderRetailDetailPage extends StatefulWidget {
  final int id;
  final String totalPrice;
  final String status;
  final String tanggalBuat;
  final List<Details> details;
  final int displayNumber;

  const OrderRetailDetailPage(
      {Key? key,
      required this.id,
      required this.totalPrice,
      required this.status,
      required this.tanggalBuat,
      required this.details,
      required this.displayNumber})
      : super(key: key);

  @override
  State<OrderRetailDetailPage> createState() => OrderRetailDetailPageState();
}

class OrderRetailDetailPageState extends State<OrderRetailDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Details> details = widget.details;
    String totalPrice = widget.totalPrice;
    String tanggalBuat = widget.tanggalBuat;
    String status = widget.status;
    Color statusColor = _getStatusColor(status);
    int displayNumber = widget.displayNumber;
    return Scaffold(
      appBar: buildAppBar(context, "ORDER DETAIL"),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      "ORDER $displayNumber",
                      18,
                      Colors.white,
                      FontWeight.bold,
                      letterSpace: 0,
                    ),
                    Row(
                      children: [
                        const TextWidget(
                          "Total Price     : ",
                          16,
                          Colors.white,
                          FontWeight.normal,
                          letterSpace: 0,
                        ),
                        TextWidget(
                          totalPrice,
                          16,
                          const Color.fromRGBO(114, 162, 138, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const TextWidget(
                          "Created At     : ",
                          16,
                          Colors.white,
                          FontWeight.normal,
                          letterSpace: 0,
                        ),
                        TextWidget(
                          tanggalBuat,
                          16,
                          Colors.white,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const TextWidget(
                          "Status Order  : ",
                          16,
                          Colors.white,
                          FontWeight.normal,
                          letterSpace: 0,
                        ),
                        TextWidget(
                          status,
                          16,
                          statusColor,
                          FontWeight.bold,
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
              SingleChildScrollView(
                child: Card(
                  color: const Color.fromRGBO(26, 26, 26, 1),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: details.length,
                    padding: const EdgeInsets.only(bottom: 10),
                    itemExtent: 130,
                    itemBuilder: (BuildContext context, int index) {
                      var detail = details[index];
                      return detailCard(
                          detail.qty!.toInt(),
                          detail.price!.toInt(),
                          detail.customerProduct!.price!.toInt(),
                          detail.customerProduct!.product!.productName
                              .toString(),
                          detail.customerProduct!.product!.image.toString(),
                          detail.customerProduct!.product!.descriprtion
                              .toString(),
                          detail.customerProduct!.product!.packaging!
                              .packagingName
                              .toString(),
                          detail.customerProduct!.product!.packaging!.weight!
                              .toInt());
                    },
                  ),
                ),
              ),

              //Item Holder
            ]),
          ),
        ),
      ),
    );
  }

  Widget detailCard(
    int qty,
    int price,
    int itemprice,
    String productname,
    String image,
    String description,
    String packagingname,
    int weight,
  ) {
    String formattedtotalitemprice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(price);
    String formatteditemprice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(itemprice);

    final fullImageUrl = '$baseURL/storage/image/$image';

    return Column(
      children: [
        Card(
          color: const Color.fromRGBO(26, 26, 26, 1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: 120,
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
                        height: 100,
                        width: 100,
                      );
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    height: 100,
                    width: 100,
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
                        productname,
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
                      Text(
                        description,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatteditemprice,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(114, 162, 138, 1),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          TextWidget(
                            "X $qty",
                            16,
                            Colors.white,
                            FontWeight.normal,
                            letterSpace: 0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            packagingname,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextWidget(
                            "$weight g",
                            16,
                            Colors.white,
                            FontWeight.normal,
                            letterSpace: 0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                            "Total Item Price :",
                            15,
                            Colors.white,
                            FontWeight.normal,
                            letterSpace: 0,
                          ),
                          Text(
                            formattedtotalitemprice,
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
