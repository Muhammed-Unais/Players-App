import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/functions/songmodelcontrollers/playlistfunctions.dart';
import 'package:provider/provider.dart';

class ExploreViewmore extends StatelessWidget {
  final String viewmoreTitile;
  final void Function() viewMoreAction;
  final bool? fromSong;
  const ExploreViewmore({
    super.key,
    required this.viewmoreTitile,
    required this.viewMoreAction,
    this.fromSong,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          viewmoreTitile,
          style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Consumer<PlaylistDbSong>(
        // Currentlt playlist working========================================
                // ==============================================================
                // ==============================================================
          // : fromSong == true
          //     ? PlaylistDbSong.texteditngcontroller
          //     : PlaylistVideoDb.videoPlaylistNotifier,
          builder: (context, value, _) {
            return value.texteditngcontroller.length > 2
                ? TextButton(
                    onPressed: viewMoreAction,
                    child: Text(
                      "View More",
                      style: GoogleFonts.raleway(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  )
                : const SizedBox(
                  height: 40,
                );
          },
        ),
      ],
    );
  }
}
