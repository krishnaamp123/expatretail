import 'package:flutter/material.dart';
import 'package:expatretail/core.dart'; // Sesuaikan impor

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String name = '';
  int _currentIndex = 0; // Track the current index

  @override
  void initState() {
    super.initState();
    // _loadUserData(); Uncomment if needed
  }

  final List<String> _imagesstore = [
    'lib/image/store1.png',
    'lib/image/store2.png',
    'lib/image/store3.png',
  ];

  final List<String> _imagesproduct = [
    'lib/image/produk1.png',
    'lib/image/produk2.png',
    'lib/image/produk3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLogo(context),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Nama
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(114, 162, 138, 1),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                "Hi,",
                                18,
                                Colors.black,
                                FontWeight.normal,
                                letterSpace: 0,
                              ),
                              TextWidget(
                                " Krishna!",
                                18,
                                Colors.black,
                                FontWeight.bold,
                                letterSpace: 0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Slider Location
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width, // Full width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: const Color.fromRGBO(26, 26, 26, 1),
                    ),
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index; // Track current slide
                              });
                            },
                          ),
                          items: _imagesstore.map((item) {
                            return Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),

                        SmoothPageIndicator(
                          controller:
                              PageController(initialPage: _currentIndex),
                          count: _imagesstore.length,
                          effect: const WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Color.fromRGBO(114, 162, 138, 1),
                          ),
                          onDotClicked: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        const SizedBox(height: 10), // Add space below the dots
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Slider Product
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width, // Full width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: const Color.fromRGBO(26, 26, 26, 1),
                    ),
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index; // Track current slide
                              });
                            },
                          ),
                          items: _imagesproduct.map((item) {
                            return Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),

                        SmoothPageIndicator(
                          controller:
                              PageController(initialPage: _currentIndex),
                          count: _imagesproduct.length,
                          effect: const WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Color.fromRGBO(114, 162, 138, 1),
                          ),
                          onDotClicked: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        const SizedBox(height: 10), // Add space below the dots
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
