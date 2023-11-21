import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageUtils {
  static String path = "/storage/emulated/0/PinterestDownloader/";
  static Future<Directory> createFolder() async {
    Directory directory = Directory(path);
    bool isGranted = await Permission.manageExternalStorage.isGranted;
    if (isGranted) {
      if (!directory.existsSync()) {
        directory.createSync();
      }
    } else {
      await Permission.manageExternalStorage.request();
      Directory directory = Directory(path);
      if (!directory.existsSync()) {
        directory.createSync();
      } else {
        Get.defaultDialog(
          title: "Please Allow Files Permission for downloading!",
          onConfirm: () async {
            await Permission.manageExternalStorage.request().then((value) {
              if (value.isGranted) {
                directory.createSync();
              }
            });
          },
        );
      }
    }
    return directory;
  }

  static Future<List<FileSystemEntity>> getFiles() async {
    List<FileSystemEntity> files = [];
    Directory directory = Directory(path);
    if (directory.existsSync()) {
      files = await directory.list().toList();
    }
    return files;
  }
}
