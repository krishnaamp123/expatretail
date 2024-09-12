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
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                    onPressed: () =>
                        pagecontroller.jumpToPage(controller.items.length - 1),
                    child: const Text("Skip",
                        style: TextStyle(
                          color: Color.fromRGBO(114, 162, 138, 1),
                        )),
                  ),

                  // Indicator
                  SmoothPageIndicator(
                    controller: pagecontroller,
                    count: controller.items.length,
                    onDotClicked: (index) => pagecontroller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    ),
                    effect: const WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      activeDotColor: Color.fromRGBO(114, 162, 138, 1),
                    ),
                  ),

                  // Next Button
                  TextButton(
                    onPressed: () => pagecontroller.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    ),
                    child: const Text("Next",
                        style: TextStyle(
                          color: const Color.fromRGBO(114, 162, 138, 1),
                        )),
                  ),
                ],
              ),
      ),
      body: Container(
        color: Colors.black,
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pagecontroller,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.asset(
                    controller.items[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
                // Dark overlay to darken the image
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Darkening effect
                  ),
                ),
                // Title and description text
                Positioned(
                  bottom: 60,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.items[index].title,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.items[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      width: MediaQuery.of(context).size.width,
      height: 48,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Text(
          "Get Started",
          style: TextStyle(
            color: const Color.fromRGBO(114, 162, 138, 1),
          ),
        ),
      ),
    );
  }
}
