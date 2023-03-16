import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/screens/music/song_search.dart/song_search_songs.dart';
import 'package:players_app/widgets/allSongs&Videos%20Widgets/allsongs.dart';
import 'package:players_app/widgets/allSongs&Videos%20Widgets/allvideos.dart';
import 'package:players_app/widgets/allSongs&Videos%20Widgets/tabbar_allsongsandvideos.dart';

class AllSongsAndVideosScreen extends StatefulWidget {
  final bool recheck;
  final int index;
  const AllSongsAndVideosScreen(
      {super.key, required this.recheck, required this.index});

  @override
  State<AllSongsAndVideosScreen> createState() =>
      _AllSongsAndVideosScreenState();
}

class _AllSongsAndVideosScreenState extends State<AllSongsAndVideosScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int myIndex = 0;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.index,
    );
    tabController.addListener(_handleTabBarSelection);
    tabController.notifyListeners();
    super.initState();
  }

  void _handleTabBarSelection() {
    setState(
      () {
        myIndex = tabController.index;
      },
    );
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabBarSelection);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.index,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.square(200),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.3, color: Colors.black),
                  ),
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/pexels-pixabay-210766.jpg"),
                      fit: BoxFit.cover),
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: TabbarAllSongsVideos(
                      tabController: tabController,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 20,
                right: 10,
                child: SizedBox(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        myIndex == 0 ? "All Songs" : "All Videos",
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SongSearchScreen(
                                  songOrVideoCheck: myIndex == 0 ? true : false,
                                );
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            AllSongs(),
            AllVidoes(),
          ],
        ),
      ),
    );
  }
}
