import 'package:attendease/employee_login.dart';
import 'package:attendease/admin_login.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF5F5F5), // Background color
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
                    "COMPANY PORTAL",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4682B4), // Matching the color scheme
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "welcome, how would you\nlike to login?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeeLogin()));
                      
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Color(0xFFFFA07A),
                    ),
                    child: Text(
                      "Login as Employee",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
                      
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Color(0xFFFFA07A),
                    ),
                    child: Text(
                      "Login as Admin",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Handle Forgot Password
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF87CEFA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
