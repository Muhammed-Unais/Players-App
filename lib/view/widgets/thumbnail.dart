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

Widget thumbnail({required String path, required double hight,required double width}) {
  Color filteredColor = Colors.white.withOpacity(0);
  return Stack(
    children: [
      Container(
        height: hight ,
        width:width,
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
