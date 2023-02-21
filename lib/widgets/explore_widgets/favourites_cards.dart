import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesCards extends StatelessWidget {
  final String image;
  final String cardtext;
  final double height;
  final double width;
  final bool change;
  final IconData? firstIcon;
  final IconData? trailingicons;
  final Widget? moreVertPopupicon;
  const FavouritesCards({
    super.key,
    required this.image,
    required this.cardtext,
    required this.height,
    required this.width,
    required this.change,
    this.trailingicons,
    this.firstIcon, this.moreVertPopupicon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            ),
          ),
        ),
        Positioned(
          left: 16,
          top: 16,
          child: change == false
              ? Icon(
                  firstIcon,
                  color: Colors.white,
                  size: 16,
                )
              : Icon(firstIcon, color: Colors.white, size: 20),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Text(
            cardtext,
            style: GoogleFonts.raleway(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        Positioned(
          right: 12,
          top: 16,
          bottom: 16,
          child: change == true
              ? moreVertPopupicon!
              : const SizedBox(),
        ),
      ],
    );
  }
}
