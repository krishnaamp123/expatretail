import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class ComplaintBarPage extends StatefulWidget {
  const ComplaintBarPage({Key? key}) : super(key: key);

  @override
  State<ComplaintBarPage> createState() => _ComplaintBarPageState();
}

class _ComplaintBarPageState extends State<ComplaintBarPage> {
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
        body: SafeArea(
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: const Column(
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
                        ComplaintPage(),
                        ComplaintHistoryPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
