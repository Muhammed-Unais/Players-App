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

Widget thumbnail({required path, required bool choice}) {
  Color filteredColor = Colors.white.withOpacity(0); // 50% opacity white color
  return Stack(
    children: [
      Container(
        height: choice == true ? 130 : 210,
        width: choice == true ? 110 : 210,
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
