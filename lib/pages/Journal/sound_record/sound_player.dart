import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'sound_recorder.dart';

class SoundPlayer {
  FlutterSoundPlayer? _soundPlayer;

  bool get isPlaying => _soundPlayer!.isPlaying;

  Future init() async {
    _soundPlayer = FlutterSoundPlayer();
    await _soundPlayer!.openPlayer();
  }

  void dispose() {
    _soundPlayer!.closePlayer();
    _soundPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
 final Directory dir = await getApplicationCacheDirectory();
    // print(pathToSaveAudio);
      var newPath = File(join(dir.path, pathToSaveAudio));
    await _soundPlayer!
        .startPlayer(fromURI: newPath.path, whenFinished: whenFinished);
  }

  Future _stop() async {
    await _soundPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if (_soundPlayer!.isStopped) {
      await _play(whenFinished);
    } else {
      await _stop();
    }
  }
}
