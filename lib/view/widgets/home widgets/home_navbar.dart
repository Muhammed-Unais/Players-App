import 'package:flutter/material.dart';
import 'package:players_app/view/genaral_screens.dart/explore.dart';
import 'package:players_app/view/genaral_screens.dart/home.dart';
import 'package:players_app/view/genaral_screens.dart/settings.dart';
import 'package:players_app/view/genaral_screens.dart/all_songs_and_videos.dart';

class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  @override
  void dispose() {
    // audioPlayer.dispose();
    super.dispose();
  }

  List screens = [
    const HomeScreen(),
    const AllSongsAndVideosScreen(recheck: false,index: 0,),
    const FavouritesAndPlaylistScreen(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(currentIndex),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor:  Colors.white,
          elevation: 10,
          onTap: (index) => setState(() {
            currentIndex = index;
          },),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withAlpha(100),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.folder),
              icon: Icon(Icons.folder_outlined),
              label: "Media",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.explore),
              icon: Icon(Icons.explore_outlined),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
