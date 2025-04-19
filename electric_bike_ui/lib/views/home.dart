import 'package:electric_bike_ui/utils/images.dart';
import 'package:electric_bike_ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                Text(
                  'Zelley',
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'Serial No : 2742874',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Birth : 20 March 2023',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            bannerWidget(),
            SizedBox(height: 20),
            Row(
              children: [
                choseBikeWidget(),
                Spacer(),
                Column(
                  children: [
                    dailyTargetWidget(),
                    SizedBox(height: 10),
                    lockBikeWidget(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class lockBikeWidget extends StatelessWidget {
  const lockBikeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  'Lock',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'your bike',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 110,
            width: 65,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(Iconsax.bezier, color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}

class dailyTargetWidget extends StatelessWidget {
  const dailyTargetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            height: 110,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                'assets/bicycle.png',
                color: Colors.black,
                height: 40,
              ),
            ),
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  'Target',
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '30',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, right: 2),
            child: Text(
              'Miles in\n week',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

class choseBikeWidget extends StatelessWidget {
  const choseBikeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/cycle.png'),
          fit: BoxFit.cover,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose\nBike',
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

class bannerWidget extends StatelessWidget {
  const bannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/chain.png'),
          fit: BoxFit.cover,
        ),

        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Text(
              'The Power\n You need',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 30,
              child: Text(
                "Great! Based on the UI image you shared, here's a detailed breakdown of the font\n family, font size, weight, and other text-related attributes",
                style: GoogleFonts.roboto(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                //scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: index == 2 ? 20 : 8, // 👈 Mak
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
