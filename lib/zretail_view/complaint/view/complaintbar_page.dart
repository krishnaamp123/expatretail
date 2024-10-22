import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ComplaintRetailBarPage extends StatefulWidget {
  const ComplaintRetailBarPage({Key? key}) : super(key: key);

  @override
  State<ComplaintRetailBarPage> createState() => _ComplaintRetailBarPageState();
}

class _ComplaintRetailBarPageState extends State<ComplaintRetailBarPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBarTok(context, "COMPLAINT"),
        backgroundColor: Colors.black,
        body: const SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.warning_amber,
                        color: Color.fromRGBO(114, 162, 138, 1), size: 28),
                    text: "Submit",
                  ),
                  Tab(
                    icon: Icon(Icons.history,
                        color: Color.fromRGBO(114, 162, 138, 1), size: 28),
                    text: "History",
                  ),
                ],
                dividerColor: Color.fromRGBO(33, 33, 33, 1),
                indicatorColor: Color.fromRGBO(114, 162, 138, 1),
                labelColor: Color.fromRGBO(114, 162, 138, 1),
                unselectedLabelColor: Color.fromRGBO(33, 33, 33, 1),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ComplaintRetailPage(),
                    ComplaintRetailHistoryPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
