import 'package:electric_bike_ui/views/home.dart';
import 'package:electric_bike_ui/views/landing.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Electric Bike ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        
      ),
      routes: {
        '/': (context) => const LandingScreen(),
        // Add other routes here
        '/home': (context) => const HomeScreen(),
      },
    
    );
  }
}

