import 'package:flutter/material.dart';
import 'package:expatretail/core.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final controller = LandingItems();
  final pagecontroller = PageController();

  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          color: Colors.black,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: isLastPage
              ? getStarted()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Skip Button
                    TextButton(
                        onPressed: () => pagecontroller
                            .jumpToPage(controller.items.length - 1),
                        child: const Text("Skip",
                            style: const TextStyle(color: Colors.white))),

                    //Indicator
                    SmoothPageIndicator(
                        controller: pagecontroller,
                        count: controller.items.length,
                        onDotClicked: (index) => pagecontroller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn),
                        effect: const WormEffect(
                            dotHeight: 12,
                            dotWidth: 12,
                            activeDotColor: Colors.white)),

                    //Next Button
                    TextButton(
                        onPressed: () => pagecontroller.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn),
                        child: const Text("Next",
                            style: const TextStyle(color: Colors.white)))
                  ],
                ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: PageView.builder(
              onPageChanged: (index) => setState(
                  () => isLastPage = controller.items.length - 1 == index),
              itemCount: controller.items.length,
              controller: pagecontroller,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        controller.items[index].image,
                        fit: BoxFit
                            .cover, // Ensures the image fills the available space
                        width: double
                            .infinity, // Takes the full width of the screen
                        height: double
                            .infinity, // Takes the full height of the available space
                      ),
                    ),
                    Text(controller.items[index].title,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Text(controller.items[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey)),
                  ],
                );
              }),
        ));
  }

  Widget getStarted() {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashboardPage()));
        },
        child: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
