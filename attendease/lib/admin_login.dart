import 'package:flutter/material.dart';

class AdminLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background and decorative rectangles
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
                  top: 600, // Positioned relative to the top of the screen
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
                  bottom: -5, // Positioned relative to the bottom of the screen
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
              ],
            ),
          ),
          // Back arrow icon at the top left
          Positioned(
            top: 40,  // You can adjust this value to position the arrow higher or lower
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop(); // Go back to the previous page
              },
            ),
          ),
          // Login Form
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF71A3B8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Admin Email",
                          prefixIcon: Icon(Icons.language, color: Colors.white),
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Company Pin",
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "OTP",
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Resend OTP functionality
                          },
                          child: Text(
                            "Resend otp",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Login functionality
                  },
                  child: Text("LOGIN"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
