import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/displays/audio_journal_display.dart';
import '../../../components/displays/back_appbar.dart';

import '../../../requests/auth_request.dart';
import '../../../utils/colours.dart';

class AudioNotesPage extends StatefulWidget {
  const AudioNotesPage({Key? key}) : super(key: key);
  @override
  State<AudioNotesPage> createState() => _AudioNotesPageState();
}

class Journals {
  final dynamic id;
  final dynamic title;
  final dynamic content;
  final dynamic date;

  Journals(
      {required this.id,
      required this.date,
      required this.content,
      required this.title});
}

class _AudioNotesPageState extends State<AudioNotesPage> {
  bool _isLoading = false;
  String? username = "user";
  dynamic userImage = " ";
  List<Journals> journalList = [];
  List<Map<String, String>> journalData = [];

  @override
  void initState() {
    super.initState();
    showInfo();
    loadSharedPreferences();
    // Call showInfo when the widget is inserted into the tree.
  }

  Future<void> loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      userImage = prefs.getString("image");
    });
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the user ID from SharedPreferences
    String? userId = prefs.getString("userId");

    if (userId != null) {
      var response = await getAudioJournal(userId);

      if (response != null) {
        var journalData = response;
        // print("here"+postData);
        journalList = (journalData as List).map((journal) {
          return Journals(
            id: journal["id"],
            date: journal["Date"],
            content: journal["content"],
            title: journal["title"],
          );
        }).toList();
      }

      setState(() {
        _isLoading = false;
      });

      // print(journalList[0].toString());
    } else {
      // Handle the case where userId is null
      print("User ID is null");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: backButtonAppbar(() => null, "Audio Notes", secondaryColor),
        backgroundColor: secondaryColor,
        body: Column(
          children: [
            if (journalList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SvgPicture.asset(
                  "assets/Empty/BlankNote.svg",
                  alignment: Alignment.center,
                  width: 100,
                  height: 300,
                ),
              ),
            if (journalList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: journalList.length,
                  itemBuilder: (context, index) {
                    final info = journalList[index];
                    return AudioJournalDisplay(
                      props: AudioJournalProps(
                        date: info.date,
                        title: info.title,
                        nId: info.id,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
