// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';

import '../../components/inputs/app_textfield.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import 'journal_page.dart';
import 'sound_record/sound_player.dart';
import 'sound_record/sound_recorder.dart';
import 'sound_record/timer_widget.dart';

class RecordJournalPage extends StatefulWidget {
  const RecordJournalPage({Key? key}) : super(key: key);
  @override
  State<RecordJournalPage> createState() => _RecordJournalPageState();
}

class _RecordJournalPageState extends State<RecordJournalPage> {
  final recorder = SoundRecorder();
  final timerController = TimerController();
  final titleTextController = TextEditingController();
  final player = SoundPlayer();
  bool isButtonDisabled = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    player.dispose();
    recorder.dispose();

    super.dispose();
  }

  void isTextFieldBlankValidation() {
    if (titleTextController.text.isEmpty) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = player.isPlaying;
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? "STOP" : "START";
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.red;
    final icon2 = isPlaying ? Icons.stop : Icons.play_arrow;
    final text2 = isPlaying ? "Stop Playing" : "Play Recording";

    void userButtonClick() async {
      setState(() {
        _isLoading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();

      // final Directory dir = await getApplicationDocumentsDirectory();

      // print(prefs.getString("TempAudio"));
      // print(File(join(dir.path, pathToSaveAudio)));

      var response = await createAudioJournal(
          content: prefs.getString("TempAudio"),
          title: titleTextController.text,
          userId: prefs.getString("userId"));

      if (response["status"] == 200) {
        Get.to(const JournalPage());
      } else {
        print("rerror");
      }
      setState(() {
        _isLoading = false;
      });
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: backButtonAppbar(() {}, "Record Journal", secondaryColor),
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        label: "Title",
                        hint: "title",
                        // key: Key(1.toString()),
                        textController: titleTextController,
                        onChanged: (text) {
                          isTextFieldBlankValidation();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TimerWidget(controller: timerController),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(175, 50),
                              backgroundColor: primary,
                              foregroundColor: onPrimary),
                          label: Text(
                            text,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          icon: Icon(icon),
                          onPressed: () async {
                            await recorder.togglRecording();
                            final isRecording = recorder.isRecording;
                            setState(() {});

                            if (isRecording) {
                              timerController.startTimer();
                            } else {
                              timerController.stopTimer();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(175, 50),
                              backgroundColor: primary,
                              foregroundColor: onPrimary),
                          label: Text(
                            text2,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          icon: Icon(icon2),
                          onPressed: () async {
                            await player.togglePlaying(
                                whenFinished: () => setState(() {}));
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                        buttonColour: primaryColor,
                        text: _isLoading ? "Loading..." : "Create Note",
                        onPress: userButtonClick,
                        // onPress: () {},
                        isDisabled: isButtonDisabled,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
