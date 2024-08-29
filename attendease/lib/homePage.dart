import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // Simulate a loading delay of 3 seconds
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFF5F5F5), // Background color similar to your image
            child: Stack(
              children: [
                Positioned(
                  top: -30,
                  left: 250,
                  child: Transform.rotate(
                    angle: 0.7,
                    child: Container(
                      width: 85,
                      height: 180,
                      color: Color(0xFFFFA07A), // Color for the top diagonal rectangle
                    ),
                  ),
                ),
                Positioned(
                  top: -60,
                  left: 350,
                  child: Transform.rotate(
                    angle: 0.7,
                    child: Container(
                      width: 70,
                      height: 350,
                      color: Color(0xFF87CEFA), // Color for the middle diagonal rectangle
                    ),
                  ),
                ),
                Positioned(
                  top: 600, // Moved up
                  left: 50,
                  child: Transform.rotate(
                    angle: 0.7,
                    child: Container(
                      width: 80,
                      height: 250,
                      color: Color(0xFF4682B4), // Color for the bottom diagonal rectangle
                    ),
                  ),
                ),
                Positioned(
                  bottom: -5, // Moved down
                  left: -20,
                  child: Transform.rotate(
                    angle: 0.7,
                    child: Container(
                      width: 80,
                      height: 300,
                      color: Color(0xFFFFA07A), // Same color as the top rectangle
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "ATTEND",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4682B4), // Matching the color scheme
                        ),
                      ),
                      Text(
                        "EASE",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4682B4), // Matching the color scheme
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 3.0),
                              blurRadius: 3.0,
                              color: Color(0xFF000000),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40), // Adjust this height to move the loader down
                      LoadingAnimationWidget.twistingDots(
                        leftDotColor: const Color(0xFF4682B4),
                        rightDotColor: const Color(0xFFFFA07A),
                        size: 70,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
