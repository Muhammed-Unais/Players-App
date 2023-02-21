import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeViewmore extends StatelessWidget {
  final String homeViewmoreTitile;
  final void Function() homeViewMoreAction;
  final bool? homefromSong;
  const HomeViewmore({
    super.key,
    required this.homeViewmoreTitile,
    required this.homeViewMoreAction,
    this.homefromSong, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          homeViewmoreTitile,
          style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        TextButton(
          onPressed: homeViewMoreAction,
          child: Text("View More",
            style: GoogleFonts.raleway(
                fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
