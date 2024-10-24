import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ComplaintRetailHistoryPage extends StatefulWidget {
  const ComplaintRetailHistoryPage({super.key});

  @override
  State<ComplaintRetailHistoryPage> createState() =>
      _ComplaintRetailHistoryPageState();
}

class _ComplaintRetailHistoryPageState
    extends State<ComplaintRetailHistoryPage> {
  var complaintCon = Get.put(ComplaintRetailController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
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
      color: const Color.fromRGBO(114, 162, 138, 1),
      child: isDataLoaded
          ? Obx(
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
                            complaint.description.toString(),
                            complaint.status.toString(),
                            complaint.solution.toString());
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

  Widget complaintlistCard(String complaintDate, String productionCode,
      String description, String status, String solution) {
    DateTime parsedDate = DateTime.parse(complaintDate);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    Color statusColor = _getStatusColor(status);
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
              Row(
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
                    width: 5,
                  ),
                  TextWidget(
                    productionCode,
                    15,
                    const Color.fromRGBO(114, 162, 138, 1),
                    FontWeight.normal,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                ],
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
                height: 2,
              ),
              TextWidget(
                status,
                16,
                statusColor,
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              if (status == 'solved') ...[
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  solution,
                  15,
                  Colors.white,
                  FontWeight.normal,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
              ],
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'unsolved':
        return Colors.orange;
      case 'solved':
        return const Color.fromRGBO(114, 162, 138, 1);
      default:
        return const Color.fromRGBO(26, 26, 26, 1);
    }
  }
}
