import 'package:electric_bike_ui/products/screen/detail_screen.dart';
import 'package:electric_bike_ui/products/screen/product_screen.dart';

import 'package:electric_bike_ui/views/botton_navBar.dart';
import 'package:electric_bike_ui/views/home.dart';
import 'package:get/get.dart';
import 'package:electric_bike_ui/views/route_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Electric Bike ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        
      ),
      routes: {
        '/': (context) => const ProductListScreen(),
        // Add other routes here
        '/home': (context) => const HomeScreen(),
        '/route': (context) => const RouteScreen(),
        '/navbar': (context) => const BottonNavbar(),
       
        
      },
    
    );
  }
}

