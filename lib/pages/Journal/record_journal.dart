import 'package:flutter/material.dart';


import '../../components/displays/back_appbar.dart';

import '../../utils/colours.dart';
import 'sound_record/sound_recorder.dart';
import 'sound_record/timer.dart';

class RecordJournalPage extends StatefulWidget {
  const RecordJournalPage({Key? key}) : super(key: key);
  @override
  State<RecordJournalPage> createState() => _RecordJournalPageState();
}

class _RecordJournalPageState extends State<RecordJournalPage> {
  final recorder = SoundRecorder();
  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? "STOP" : "START";
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.red;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: backButtonAppbar(() {}, "Record Journal", secondaryColor),
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          "Coming Soon",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(175, 50),
                            backgroundColor: primary,
                            foregroundColor: onPrimary),
                        label: Text(
                          text,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        icon: Icon(icon),
                        onPressed: () async {
                          final isRecording = await recorder.togglRecording();
                       setState(() {
                         
                       });
                        },

                        
                      ),

                      TimerPage()

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
