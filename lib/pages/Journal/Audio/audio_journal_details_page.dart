import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/displays/back_appbar.dart';
import '../../../requests/auth_request.dart';
import '../../../utils/colours.dart';
import '../Sound_Player/player_timer.dart';
import '../Sound_Player/saved_player.dart';

class AudioJournalDetailsPage extends StatefulWidget {
  final String nId;
  const AudioJournalDetailsPage(this.nId, {Key? key}) : super(key: key);
  @override
  State<AudioJournalDetailsPage> createState() =>
      _AudioJournalDetailsPageState();
}

class AudioJournal {
  final dynamic id;
  String title;
  dynamic content;
  dynamic date;

  AudioJournal(
      {required this.id,
      required this.date,
      required this.content,
      required this.title});
}

class _AudioJournalDetailsPageState extends State<AudioJournalDetailsPage> {
  bool _isLoading = false;
  AudioJournal? journInfo =
      AudioJournal(id: "id", date: "date", content: "content", title: "title");
  final timerController = PlayerTimerController();
  final player = SavedSoundPlayer(newUri: null);

  @override
  void initState() {
    super.initState();
    player.init();
    showInfo();
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the user ID from SharedPreferences
    String? userId = prefs.getString("userId");
    final response = await getAudioNote(userId: userId, noteId: widget.nId);

    // print(response);
    setState(() {
      journInfo?.content = response["content"];
      journInfo?.title = response["title"];
      journInfo?.date = response["Date"];
      _isLoading = false;
    });

    // print(journInfo?.content);

    player.newUri = journInfo?.content;

    await player.playAudioFromBase64();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = player.isPlaying;
    final icon2 = isPlaying ? Icons.stop : Icons.play_arrow;
    final text2 = isPlaying ? "Stop Playing" : "Play Recording";
    final primary = isPlaying ? Colors.red : Colors.white;
    final onPrimary = isPlaying ? Colors.white : Colors.red;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar:
            backButtonAppbar(() {}, journInfo?.title ?? " ", secondaryColor),
        backgroundColor: secondaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Adjust alignment as needed
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: whiteColor,
                                ),
                                Text(
                                  "Delete", // Add your additional text here
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      PlayerTimerWidget(controller: timerController),
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
                    ],
                  )
                ]),
          ),
        )),
      ),
    );
  }
}
