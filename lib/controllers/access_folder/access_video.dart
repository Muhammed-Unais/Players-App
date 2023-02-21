
import 'package:permission_handler/permission_handler.dart';
import 'package:players_app/controllers/access_folder/method_channel_fn.dart';

List<String> accessVideosPath = [];

// ValueNotifier accessVideosPath = ValueNotifier([]);

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

Future splashFetch() async {
  if (await requestPermission(Permission.storage)) {
    AccessFilesFromStorage.accessFromStorage([
      '.mkv',
      '.mp4',
    ], onSuccess, (p0) {});
    
  } else {
    splashFetch();
  }
}

onSuccess(List<String> path) {
  accessVideosPath = path;
  for (var i = 0; i < accessVideosPath.length; i++) {
    if (accessVideosPath[i].startsWith('/storage/emulated/0/Android/data')) {
      accessVideosPath.remove(accessVideosPath[i]);
      i--;
    }
  }
}
