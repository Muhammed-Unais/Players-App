import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabbarAllSongsVideos extends StatelessWidget {

  final TabController tabController;
  const TabbarAllSongsVideos({
    super.key,  required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: tabController,
        splashBorderRadius: BorderRadius.circular(20),
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.white),
          ),
        ),
        labelPadding:
            const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
        isScrollable: true,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.values[1],
        tabs: [
          Text(
            "All SONGS",
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            "ALL VIDEOS",
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
