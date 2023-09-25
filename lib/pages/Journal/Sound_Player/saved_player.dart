import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SavedSoundPlayer {
  FlutterSoundPlayer? _soundPlayer;

  bool get isPlaying => _soundPlayer!.isPlaying;
  dynamic newUri;

  SavedSoundPlayer({this.newUri});

  Future init() async {
    _soundPlayer = FlutterSoundPlayer();
    await _soundPlayer!.openPlayer();
  }

  void dispose() {
    _soundPlayer!.closePlayer();
    // _soundPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
    // final Directory dir = await getApplicationCacheDirectory();
    // print(pathToSaveAudio);
    final Directory dir = await getApplicationCacheDirectory();
    String tempFilePath = 'path_to_temp_audio_file.aac';

    var newPath = File(join(dir.path, tempFilePath));

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

  Future playAudioFromBase64() async {
    // print(newUri);
    if (newUri != null && newUri.startsWith('data:audio/aac;base64,')) {
      // Extract the Base64 audio data (remove the data URI prefix)

      String base64AudioData = newUri.split(',')[1];

      // Decode the Base64 data to obtain binary audio content
      Uint8List audioBytes = Uint8List.fromList(base64.decode(base64AudioData));

      // Define a temporary file path to save the audio file
      String tempFilePath = 'path_to_temp_audio_file.aac';

      final Directory dir = await getApplicationCacheDirectory();

      // Write the binary audio content to the temporary file
      File tempAudioFile = File(join(dir.path, tempFilePath));
      print("here" + tempAudioFile.path);
      await tempAudioFile.writeAsBytes(audioBytes);

      // Play the audio from the temporary file
      await _play(() {
        // Playback finished callback (you can handle this as needed)
        // You might want to delete the temporary file here
        tempAudioFile.delete();
      });
    }
  }
}
