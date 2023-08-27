import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteExploreCard extends StatelessWidget {
  const FavouriteExploreCard({super.key, required this.cardTitile});

  final String cardTitile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.435,
      height: size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          colors: [Colors.grey[500]!, Colors.white38],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 0.2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Icon(
              Icons.favorite,
              color: Colors.grey[800],
              size: 22.0,
            ),
          ),
          Center(
            child: Text(
              cardTitile,
              style:GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
            ),
          ),
        ],
      ),
    );
  }
}
