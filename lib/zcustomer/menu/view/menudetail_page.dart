import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class MenuDetailPage extends StatefulWidget {
  final String idpaket;
  final String image;
  final String name;
  final String description;
  final String itemprice;

  const MenuDetailPage(
      {Key? key,
      required this.idpaket,
      required this.image,
      required this.name,
      required this.description,
      required this.itemprice})
      : super(key: key);

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String itemprice = widget.itemprice;
    int productprice = int.parse(itemprice);
    String formattedItemPrice =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
            .format(productprice);
    return Scaffold(
      appBar: buildAppBar(context, "MENU DETAIL"),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.image,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formattedItemPrice,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(114, 162, 138, 1),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  height: 2,
                  thickness: 4,
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
              ),
              const SizedBox(height: 15),
            ]),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.black,
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InputQty.int(
                qtyFormProps: const QtyFormProps(
                  enableTyping: false,
                  style: TextStyle(
                    color: Color.fromRGBO(114, 162, 138, 1),
                  ),
                ),
                decoration: const QtyDecorationProps(
                  isBordered: false,
                  borderShape: BorderShapeBtn.circle,
                  width: 12,
                  btnColor: Color.fromRGBO(114, 162, 138, 1),
                ),
                // initVal: jumlahKaryawan,
                minVal: 1,
                maxVal: 50,
                steps: 1,
                onQtyChanged: (value) {
                  setState(() {
                    // jumlahKaryawan = value ?? 1;
                  });
                },
              ),
              GestureDetector(
                // onTap: {},
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(114, 162, 138, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
