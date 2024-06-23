import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dh_music/utils/logging.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicPaths {
  final String directoryPath;
  final List<String> filePaths;

  MusicPaths({required this.directoryPath, required this.filePaths});
}

class FilePathController extends GetxController {
  final player = AudioPlayer();
  final RxList<String> allMusic = <String>[].obs;

  final RxList<MusicPaths> directoryToFileNames = <MusicPaths>[].obs;
  @override
  void onInit() {
    super.onInit();
    getDevicePath();
  }

  void getDevicePath() async {
    final status = await Permission.audio.status;
    if (status.isGranted) {
      Logger.info(runtimeType, 'Storage Permission is granted');
      _getAllMp3File();
    } else {
      Logger.info(runtimeType, 'Storage Permission is denied');
      await Permission.audio.request();
    }
  }

  void _getAllMp3File() async {
    Directory dir = Directory("/storage/emulated/0/");

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
          allMusic.add("$directory/$fileName");
          Logger.info(
              runtimeType, 'getAllPath allMusic count: ${allMusic.length}');
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
        Logger.error(runtimeType, "Cannot access this directory: $e");
      },
    );
  }

  void playMusic(String path) async {
    Logger.info(runtimeType, 'playMusic path: $path');
    try {
      await player.play(DeviceFileSource(path));
    } catch (e) {
      Logger.error(runtimeType, 'playMusic error: $e');
    }
  }
}
