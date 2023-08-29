
import 'package:flutter/services.dart';

class AccessFilesFromStorage {
  static const channel = MethodChannel("fetch_files_from_storage");

  static Future<void> accessFromStorage(List<String> query,
      void Function(List<String>) onSuccess, void Function(String) onError) async{
    await channel.invokeMethod('search', query).then((value) {
      final res = value as List<Object?>;
      onSuccess(res.map((e) => e.toString()).toList());
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }
}