import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTitileText extends StatelessWidget {
  const HomeTitileText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Players App",
      style:GoogleFonts.raleway(fontSize: 24, fontWeight: FontWeight.w800,color: Colors.black),
    );
  }
}
