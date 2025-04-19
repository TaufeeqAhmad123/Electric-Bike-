import 'package:electric_bike_ui/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElevetedButton extends StatelessWidget {
  void Function() onPressed;
  ElevetedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: yellow, // Background color
        foregroundColor: Colors.black, // Text color
        textStyle: GoogleFonts.poppins(
          fontSize: 19, // Font size of the text
          fontWeight: FontWeight.bold, // Font weight of the text
        ),
        fixedSize: Size(350, 65), // Fixed size of the button
        elevation: 2,
        shadowColor: Colors.black, // Shadow color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
      ),
      child: Text('Get Started'),
    );
  }
}
