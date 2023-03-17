import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Home",
        style: GoogleFonts.raleway(
            fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
