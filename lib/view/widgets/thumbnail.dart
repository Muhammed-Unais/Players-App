import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

String thumbnailFile = "";
Future<String> getthumbnail(path) async {
  return thumbnailFile = (await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG))!;
}

Widget thumbnail(
    {required String path, required double hight, required double width}) {
  Color filteredColor = Colors.white.withOpacity(0);
  return Stack(
    children: [
      Container(
        height: hight,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: FutureBuilder(
          future: getthumbnail(path),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String data = snapshot.data!;
              return ColorFiltered(
                colorFilter: ColorFilter.mode(filteredColor, BlendMode.srcATop),
                child: Image.file(
                  File(data),
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return const Text("not found");
            }
          },
        ),
      ),
    ],
  );
}

class ThumbnailAllVideos extends StatelessWidget {
  const ThumbnailAllVideos(
      {super.key,
      required this.path,
      required this.hight,
      required this.videoPathThumbnail,
      required this.width});

  final String path;
  final double hight;
  final String videoPathThumbnail;
  final double width;

  @override
  Widget build(BuildContext context) {
    Color filteredColor = Colors.white.withOpacity(0);

    return Stack(
      children: [
        Container(
          height: hight,
          width: width,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(filteredColor, BlendMode.srcATop),
            child: videoPathThumbnail.isEmpty
                ? null
                : Image.file(
                    File(videoPathThumbnail),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ],
    );
  }
}
