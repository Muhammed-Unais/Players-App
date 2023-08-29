import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:players_app/view/music/song_search.dart/song_search_songs.dart';
import 'package:players_app/view/widgets/allsongs_and_videos%20Widgets/allsongs.dart';
import 'package:players_app/view/widgets/allsongs_and_videos%20Widgets/allvideos.dart';
import 'package:players_app/view/widgets/allsongs_and_videos%20Widgets/tabbar_allsongsandvideos.dart';

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
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/images/wepik-export-20230828135001zGdl.png",
                    fit: BoxFit.cover,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SongSearchScreen(
                              isSong: myIndex == 0 ? true : false,
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      IconlyBold.search,
                      color: Colors.black,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: TabbarAllSongsVideos(tabController: tabController),
                ),
              )
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: const [
              AllSongs(),
              AllVidoes(),
            ],
          ),
        ),
      ),
    );
  }
}
