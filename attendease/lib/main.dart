import 'package:flutter/material.dart';
import 'homePage.dart'; // Import the new screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(), // Set SplashScreen as the home screen
    );
  }
}
