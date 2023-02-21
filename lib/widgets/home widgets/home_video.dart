import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:players_app/controllers/access_folder/access_video.dart';
import 'package:players_app/screens/videos/play_video_screen.dart';
import 'package:players_app/widgets/thumbnail.dart';

class HomeVideoScreen extends StatefulWidget {
  const HomeVideoScreen({super.key});

  @override
  State<HomeVideoScreen> createState() => _HomeVideoScreenState();
}

class _HomeVideoScreenState extends State<HomeVideoScreen> {
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    if (await requestPermission(Permission.storage)) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
        if (accessVideosPath.isEmpty) {
          return const Center(
            child:CircularProgressIndicator(color: Colors.black),
          );
        }
         return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 136,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      itemCount: accessVideosPath.length > 4 ? 4 : accessVideosPath.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    // const SizedBox(height: 4,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                // Video playscreen Page
                                return PlayVideoScreen(
                                  paths: accessVideosPath,
                                  index: index,
                                  isModelorPath: false,
                                );
                              },
                            ),
                          );
                        },
                        child: accessVideosPath.isEmpty
                            ? const Center(
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/videoposter.png"),
                                ),
                              )
                            // Video thumbnail widget page
                            : thumbnail(
                                path: accessVideosPath[index].toString(),
                                choice: false),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      accessVideosPath.isNotEmpty
                          ? accessVideosPath[index].toString().split('/').last
                          : "No videos",
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
