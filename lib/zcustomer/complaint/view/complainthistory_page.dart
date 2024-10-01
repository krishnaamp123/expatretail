import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ComplaintHistoryPage extends StatefulWidget {
  const ComplaintHistoryPage({super.key});

  @override
  State<ComplaintHistoryPage> createState() => _ComplaintHistoryPageState();
}

class _ComplaintHistoryPageState extends State<ComplaintHistoryPage> {
  var complaintCon = Get.put(ComplaintController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    await complaintCon.getComplaint();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await complaintCon.getComplaint();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                  height: 700,
                  width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => complaintCon.isLoading.value
                        ? const SpinKitWanderingCubes(
                            color: Color.fromRGBO(114, 162, 138, 1),
                            size: 50.0,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: complaintCon.listComplaint.length,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (BuildContext context, int index) {
                              var complaint = complaintCon.listComplaint[index];
                              return complaintlistCard(
                                  complaint.complaintDate.toString(),
                                  complaint.productionCode.toString(),
                                  complaint.description.toString());
                            },
                          ),
                  )),
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Color.fromRGBO(114, 162, 138, 1),
              size: 50.0,
            )),
    );
  }

  Widget complaintlistCard(
      String complaintDate, String productionCode, String description) {
    DateTime parsedDate = DateTime.parse(complaintDate);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return Card(
      color: Colors.black,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                formattedDate,
                15,
                Colors.white,
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                productionCode,
                16,
                const Color.fromRGBO(114, 162, 138, 1),
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                description,
                15,
                Colors.white,
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                height: 10,
                thickness: 1,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
