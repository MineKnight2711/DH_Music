import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dh_music/utils/logging.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
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
  final RxList<Metadata> allMusic = <Metadata>[].obs;

  final RxList<MusicPaths> directoryToFileNames = <MusicPaths>[].obs;

  final Rx<PlayerState> currentPlayerState = PlayerState.stopped.obs;

  final RxList<Metadata> musicQueue = <Metadata>[].obs;

  final Rxn<Metadata> currentSong = Rxn<Metadata>();
  @override
  void onInit() {
    super.onInit();
    requestPermissionThenGetAllMp3Path();
    listenToPlayerState();
  }

  void requestPermissionThenGetAllMp3Path() async {
    //Before using DeviceInfoPlugin make sure to re-build the app
    final operationSystemVersion = await DeviceInfoPlugin().androidInfo;
    final int sdkVersion = operationSystemVersion.version.sdkInt;
    if (sdkVersion > 30) {
      final status = await Permission.audio.status;
      Logger.info(runtimeType,
          'Operating System Version: ${operationSystemVersion.version.sdkInt}');
      if (status.isGranted) {
        Logger.info(
            runtimeType, 'requestPermission Audio Permission is granted');
        _getAllMp3File();
      } else {
        Logger.info(
            runtimeType, 'requestPermission Audio Permission is denied');
        await Permission.audio.request();
      }
    } else if (sdkVersion == 30) {
      final status = await Permission.storage.status;
      Logger.info(runtimeType,
          'Operating System Version: ${operationSystemVersion.version.sdkInt}');
      if (status.isGranted) {
        Logger.info(
            runtimeType, 'requestPermission Storage Permission is granted');
        _getAllMp3File();
      } else {
        Logger.info(
            runtimeType, 'requestPermission Storage Permission is denied');
        await Permission.storage.request();
      }
    }
  }

  void _getAllMp3File() async {
    Directory dir = Directory("/storage/emulated/0/");

    Stream<FileSystemEntity> files =
        dir.list(recursive: true, followLinks: false);
    files.listen(
      (file) async {
        String path = file.path;
        if (path.contains('/Android/')) {
          return;
        } else if (path.endsWith('.mp3')) {
          Logger.info(runtimeType, 'getAllPath  : $path');
          final directory = path.substring(0, path.lastIndexOf('/'));
          Logger.info(runtimeType, 'getAllPath directory: $directory');

          final fileName = path.substring(path.lastIndexOf('/') + 1);
          Logger.info(runtimeType, 'getAllPath fileName: $fileName');
          //
          allMusic.add(await MetadataRetriever.fromFile(File(path)));
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
        Logger.error(runtimeType, "getAllPath cannot access directory: $e");
      },
    ).onError((e) {
      Logger.error(runtimeType, "getAllPath cannot access directory: $e");
    });
  }

  void listenToPlayerState() {
    player.onPlayerStateChanged.listen((event) {
      currentPlayerState.value = event;
    });
  }

  // void addToQueue(String musicPath) {
  //   musicQueue.add(musicPath);
  // }

  void startMusic(String path,
      {List<Metadata> addToQueueList = const []}) async {
    Logger.info(runtimeType, 'playMusic path: $path');
    currentSong.value = await MetadataRetriever.fromFile(File(path));
    try {
      if (musicQueue.isEmpty) {
        musicQueue.addAll(addToQueueList);
      }
      player.stop().then(
        (value) {
          player.play(DeviceFileSource(path));
        },
      );
    } catch (e) {
      Logger.error(runtimeType, 'playMusic error: $e');
    }
  }

  void playOrPause() {
    if (currentPlayerState.value == PlayerState.playing) {
      player.pause();
    } else if (currentPlayerState.value == PlayerState.paused) {
      player.resume();
    }
  }

  void stopMusic() async {
    try {
      await player.pause();
    } catch (e) {
      Logger.error(runtimeType, 'pause error: $e');
    }
  }
}
