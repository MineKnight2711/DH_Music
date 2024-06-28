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

enum PlayType { all, single, repeat }

class FilePathController extends GetxController {
  final player = AudioPlayer();
  final RxList<Metadata> allMusic = <Metadata>[].obs;

  final RxList<MusicPaths> directoryToFileNames = <MusicPaths>[].obs;

  final Rx<PlayerState> currentPlayerState = PlayerState.stopped.obs;
  final Rx<PlayType> currentPlayeType = PlayType.all.obs;

  final RxList<Metadata> musicQueue = <Metadata>[].obs;
  final RxList<Metadata> shuffledQueue = <Metadata>[].obs;

  final Rx<Duration> currentDuration = Rx<Duration>(Duration.zero);
  final Rxn<Metadata> currentSong = Rxn<Metadata>();

  final RxBool isShuffle = false.obs;
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
    Logger.info(runtimeType,
        'requestPermission Operating System Version: ${operationSystemVersion.version.sdkInt}');
    if (sdkVersion > 30) {
      final status = await Permission.audio.status;

      if (status.isGranted) {
        Logger.info(
            runtimeType, 'requestPermission Audio Permission is granted');
        _getAllMp3File();
      } else {
        Logger.info(
            runtimeType, 'requestPermission Audio Permission is denied');
        await Permission.audio.request().whenComplete(() => _getAllMp3File());
      }
    } else if (sdkVersion <= 30) {
      final status = await Permission.storage.status;

      if (status.isGranted) {
        Logger.info(
            runtimeType, 'requestPermission Storage Permission is granted');
        _getAllMp3File();
      } else {
        Logger.info(
            runtimeType, 'requestPermission Storage Permission is denied');
        await Permission.storage.request().whenComplete(
              () => _getAllMp3File(),
            );
      }
    }
  }

  void shuffle() {
    if (isShuffle.value) {
      shuffledQueue.clear();
      shuffledQueue.addAll(musicQueue);
      shuffledQueue.shuffle();
      if (currentSong.value != null) {
        shuffledQueue.removeWhere(
            (element) => element.filePath == currentSong.value?.filePath);

        shuffledQueue.insert(0, currentSong.value!);
      }
    } else {
      shuffledQueue.clear();
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
    );
  }

  void listenToPlayerState() {
    player.onPlayerStateChanged.listen((state) {
      Logger.info(runtimeType, 'listenToPlayerState : $state');
      currentPlayerState.value = state;
      if (currentPlayerState.value == PlayerState.completed) {
        playNext();
      }
    });
    player.onPositionChanged.listen((duration) {
      currentDuration.value = duration;
    });
  }

  void seekDuration(Duration duration) {
    Logger.info(runtimeType, 'seekDuration : $duration');
    if (currentSong.value != null) {
      currentDuration.value = duration;
      player.seek(duration);
    }
  }

  void playPrevious() {
    if (musicQueue.isNotEmpty && shuffledQueue.isEmpty) {
      final index = musicQueue
          .indexWhere((song) => currentSong.value?.filePath == song.filePath);

      Logger.info(runtimeType, 'previousNext previous index $index');
      if (index > 0) {
        startMusic(musicQueue[index - 1].filePath ?? "");
      }
    } else if (shuffledQueue.isNotEmpty) {
      final index = shuffledQueue
          .indexWhere((song) => currentSong.value?.filePath == song.filePath);

      Logger.info(runtimeType, 'previousNext previous index $index');
      if (index > 0) {
        startMusic(shuffledQueue[index - 1].filePath ?? "");
      }
    }
  }

  void playNext() {
    if (musicQueue.isNotEmpty && shuffledQueue.isEmpty) {
      final index = musicQueue
          .indexWhere((song) => currentSong.value?.filePath == song.filePath);

      Logger.info(runtimeType, 'previousNext previous index $index');
      if (index >= 0 && index < musicQueue.length - 1) {
        startMusic(musicQueue[index + 1].filePath ?? "");
      }
    } else if (shuffledQueue.isNotEmpty) {
      final index = shuffledQueue
          .indexWhere((song) => currentSong.value?.filePath == song.filePath);

      Logger.info(runtimeType, 'previousNext previous index $index');
      if (index >= 0 && index < shuffledQueue.length - 1) {
        startMusic(shuffledQueue[index + 1].filePath ?? "");
      }
    }
  }

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
    } else if (currentPlayerState.value == PlayerState.completed) {
      currentDuration.value = Duration.zero;
      startMusic(currentSong.value?.filePath ?? "");
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
