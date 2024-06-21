import 'dart:io';

import 'package:dh_music/utils/logging.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicPaths {
  final String directoryPath;
  final List<String> filePaths;

  MusicPaths({required this.directoryPath, required this.filePaths});
}

class FilePathController extends GetxController {
  final RxList<MusicPaths> directoryToFileNames = <MusicPaths>[].obs;
  @override
  void onInit() {
    super.onInit();
    requestPermission();
  }

  void requestPermission() async {
    final status = await Permission.audio.status;
    if (status.isGranted) {
      Logger.info(runtimeType, 'Storage Permission is granted');
      getAllPath();
    } else {
      Logger.info(runtimeType, 'Storage Permission is denied');
      await Permission.audio.request();
    }
  }

  void getAllPath() async {
    Directory dir = Directory('/storage/emulated/0/');

    Stream<FileSystemEntity> files =
        dir.list(recursive: true, followLinks: false);
    files.listen(
      (file) {
        String path = file.path;
        if (path.contains('/Android/')) {
          return;
        } else if (path.endsWith('.mp3')) {
          final directory = path.substring(0, path.lastIndexOf('/'));
          Logger.info(runtimeType, 'getAllPath directory: $directory');

          final fileName = path.substring(path.lastIndexOf('/') + 1);
          Logger.info(runtimeType, 'getAllPath fileName: $fileName');

          final uniquePaths = directoryToFileNames
              .where((element) => element.directoryPath == directory);
          if (uniquePaths.isEmpty) {
            directoryToFileNames.add(
                MusicPaths(directoryPath: directory, filePaths: [fileName]));
          } else {
            uniquePaths.first.filePaths.add(fileName);
          }
        }
      },
      onDone: () {
        Logger.info(runtimeType,
            'getAllPath Songs list count: ${directoryToFileNames.length}');
      },
      onError: (e) {
        // Handle the error
        // Logger.error(runtimeType, "Cannot access this directory: $e");
      },
    );
  }
}
