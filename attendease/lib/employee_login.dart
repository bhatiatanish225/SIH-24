
import 'package:attendease/employee_dashboard.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class EmployeeLogin extends StatefulWidget {
  @override
  _EmployeeLoginState createState() => _EmployeeLoginState();
}

class _EmployeeLoginState extends State<EmployeeLogin> {
  bool _isOTPSent = false;
  int _remainingTime = 20;
  Timer? _timer;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void _startTimer() {
    _remainingTime = 20; // reset the timer
    _timer?.cancel(); // cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _isOTPSent = false;
        }
      });
    });
  }

  void _sendOTP() {
    if (_emailController.text.isEmpty ||
        _employeeIdController.text.isEmpty) {
      _showErrorMessage("Please enter all details.");
      return;
    }

    setState(() {
      _isOTPSent = true;
    });
    _startTimer();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // cancel the timer when the widget is disposed
    _emailController.dispose();
    _employeeIdController.dispose();
    _otpController.dispose();
    super.dispose();
  }

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
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Work Email",
                          prefixIcon: Icon(Icons.language, color: Colors.white),
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _employeeIdController,
                        decoration: InputDecoration(
                          labelText: "Employee ID",
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          labelText: "OTP",
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _isOTPSent
                            ? null
                            : _sendOTP, // Disable button if OTP is sent
                        child: Text(
                          _isOTPSent ? "Resend OTP in $_remainingTime s" : "Send OTP",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isOTPSent ? Colors.grey : Colors.orange,
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeeDashboard()));
                   
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
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Contact admin functionality
                  },
                  child: Text(
                    "Don't have login details?\nCONTACT ADMIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
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
