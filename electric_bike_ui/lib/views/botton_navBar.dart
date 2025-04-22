import 'package:electric_bike_ui/utils/images.dart';
import 'package:electric_bike_ui/views/home.dart';
import 'package:electric_bike_ui/views/landing.dart';
import 'package:electric_bike_ui/views/route_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottonNavbar extends StatefulWidget {
  const BottonNavbar({super.key});

  @override
  State<BottonNavbar> createState() => _BottonNavbarState();
}

class _BottonNavbarState extends State<BottonNavbar> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const RouteScreen(),
    const LandingScreen(),
    const LandingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          selectedItemColor: yellow,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.black,

          type: BottomNavigationBarType.fixed,

          showUnselectedLabels: false,
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(Iconsax.home_15),
              ),
              label: '',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(Iconsax.camera),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(Iconsax.activity),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(Iconsax.user),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
