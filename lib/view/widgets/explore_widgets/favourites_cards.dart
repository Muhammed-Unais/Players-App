import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesCards extends StatelessWidget {
  final String cardtext;
  final double height;
  final double width;

  final IconData? firstIcon;
  final IconData? trailingicons;
  final Widget? moreVertPopupicon;
  const FavouritesCards({
    super.key,
    required this.cardtext,
    required this.height,
    required this.width,
    this.trailingicons,
    this.firstIcon,
    this.moreVertPopupicon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(
          colors: [Color(0xffb9b9b9), Color(0xffe8edef)],
          stops: [0, 1],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0.1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            bottom: 26,
            top: 26,
            child: Icon(firstIcon, color: Colors.black, size: 24),
          ),
          Center(
            child: Text(
              cardtext,
              style:GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
            ),
          ),
          Positioned(right: 12, top: 16, bottom: 16, child: moreVertPopupicon!),
        ],
      ),
    );
  }
}
