import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:players_app/view/genaral_screens.dart/explore.dart';
import 'package:players_app/view/genaral_screens.dart/home.dart';
import 'package:players_app/view/genaral_screens.dart/all_songs_and_videos.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<dynamic> screens = [
    const HomeScreen(),
    const AllSongsAndVideosScreen(recheck: false, index: 0),
    const FavouritesAndPlaylistScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(currentIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey,width: 0.4),
          ),
        ),
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          onTap: (index) => setState(
            () {
              currentIndex = index;
            },
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withAlpha(100),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(IconlyBold.folder),
              icon: Icon(IconlyBold.folder),
              label: "Media",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.explore),
              icon: Icon(Icons.explore),
              label: "Favorites",
            ),
          ],
        ),
      ),
    );
  }
}
