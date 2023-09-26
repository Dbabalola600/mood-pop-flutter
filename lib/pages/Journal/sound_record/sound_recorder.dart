import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

var pathToSaveAudio = "audio_record_mood.aac";

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;

  bool _isRecorderInitialised = false;

  bool get isRecording => _audioRecorder!.isRecording;
  Future<void> init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("microphone permission");
    }

    await _audioRecorder!.openRecorder();
    _isRecorderInitialised = true;
  }

  void dispose() {
    if (!_isRecorderInitialised) return;

    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record() async {
    final Directory dir = await getApplicationCacheDirectory();

    if (Platform.isIOS) {
      var newPath = File(join(dir.path, pathToSaveAudio));

      await _audioRecorder!.startRecorder(toFile: newPath.path);
    } else {
      var newPath = File(join(dir.path, pathToSaveAudio));
      await _audioRecorder!.startRecorder(toFile: newPath.path);
    }
  }

  Future _stop() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.stopRecorder();
  }

  Future togglRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
      await saveAudioAsBase64();
    }
  }

  Future saveAudioAsBase64() async {
    // final audioFile = File(pathToSaveAudio);

    try {
      if (Platform.isIOS) {
        final Directory dir = await getApplicationCacheDirectory();
        final String iosFilePath = File(join(dir.path, pathToSaveAudio)).path;

        final File iosFile = File(iosFilePath);

        if (await iosFile.exists()) {
          final List<int> bytes = await iosFile.readAsBytes();
          // final String base64String = base64Encode(bytes);
          final String base64String =
              'data:audio/aac;base64,${base64Encode(bytes)}';

          // Save the Base64 string to SharedPreferences.
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("TempAudio", base64String);
        } else {
          print("error stilll");
        }
      } else {
        if (pathToSaveAudio.isNotEmpty) {
          final Directory dir = await getApplicationCacheDirectory();
          final String FilePath = File(join(dir.path, pathToSaveAudio)).path;

          final File otherFile = File(FilePath);

          if (await otherFile.exists()) {
            final List<int> bytes = await otherFile.readAsBytes();
            final String base64String =
                'data:audio/aac;base64,${base64Encode(bytes)}';

            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setString("TempAudio", base64String);
          } else {
            print("error stilll");
          }

          // final bytes = await audioFile.readAsBytes();
          // final base64String = base64Encode(bytes);
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString("TempAudio", base64String);
        }
      }
    } catch (e) {
      print("error $e");
    }
  }
}
