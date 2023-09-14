import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:players_app/controllers/video_folder/access_folder/method_channel_fn.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoFileAccessFromStorage with ChangeNotifier {
  bool isInitialize = false;

  bool thumbnailIntilize = false;

  List<String> accessVideosPath = [];

  List<String> videoPathThumbnail = [];

  Future<bool> requestPermission(Permission permission) async {
    const storage = Permission.storage;
    const mediaLocationAccess = Permission.accessMediaLocation;
    if (await permission.isGranted) {
      await mediaLocationAccess.isGranted && await storage.isGranted;
      return true;
    } else {
      var result = await storage.request();
      var mediarequest = await mediaLocationAccess.request();

      if (result == PermissionStatus.granted &&
          mediarequest == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> splashFetch() async {
    if (await requestPermission(Permission.storage)) {
      await AccessFilesFromStorage.accessFromStorage([
        '.mkv',
        '.mp4',
      ], (List<String> path) async {
        accessVideosPath = [...path];
        for (var i = 0; i < accessVideosPath.length; i++) {
          if (accessVideosPath[i]
              .startsWith('/storage/emulated/0/Android/data')) {
            accessVideosPath.remove(accessVideosPath[i]);
            i--;
          }
        }

        isInitialize = true;
        notifyListeners();

        await useIsolateforCreatingThumbnail(accessVideosPath);
      }, (p0) {
        isInitialize = false;
      });

   
    } else {
      splashFetch();
    }
  }

  Future<void> useIsolateforCreatingThumbnail(
      List<String> accessVideoPath) async {
    RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;

    if (rootIsolateToken == null) {
      return;
    }

    final ReceivePort receivePort = ReceivePort();

    try {
      await Isolate.spawn(getthumbnail,
          [receivePort.sendPort, accessVideoPath, rootIsolateToken]);
    } on Object {
      debugPrint('Isolates Failed');
      receivePort.close();
    }

    videoPathThumbnail = List.filled(accessVideoPath.length, "");
    int i = 0;

    receivePort.listen(
      (message) {
        if (!videoPathThumbnail.contains(message)) {
          videoPathThumbnail[i] = message;
          i++;
        }
      },
    );
    notifyListeners();
  }
}

Future<void> getthumbnail(List<dynamic> arg) async {
  var videoPath = arg[1] as List<String>;
  final rootIsolateToken = arg[2] as RootIsolateToken;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  try {
    for (var i = 0; i < videoPath.length; i++) {
      String? thumbNail = await VideoThumbnail.thumbnailFile(
        video: videoPath[i],
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
      );
      var sendPort = arg[0] as SendPort;
      sendPort.send(thumbNail);
    }

    Isolate.exit();
  } catch (e) {
    var sendPort = arg[0] as SendPort;
    sendPort.send(e.toString());
    Isolate.exit();
  }
}



