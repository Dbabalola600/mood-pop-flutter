import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/displays/back_appbar.dart';
import '../../../components/displays/journal_display.dart';

import '../../../components/displays/load_screen.dart';
import '../../../requests/auth_request.dart';
import '../../../utils/colours.dart';

class WrittenNotesPage extends StatefulWidget {
  const WrittenNotesPage({Key? key}) : super(key: key);
  @override
  State<WrittenNotesPage> createState() => _WrittenNotesPageState();
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

class _WrittenNotesPageState extends State<WrittenNotesPage> {
  bool _isLoading = false;
  String? username = "user";
  dynamic userImage = " ";
  List<Journals> journalList = [];
  List<Map<String, String>> journalData = [];

  @override
  void initState() {
    super.initState();
    showInfo();

    // Call showInfo when the widget is inserted into the tree.
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the user ID from SharedPreferences
    String? userId = prefs.getString("userId");

    if (userId != null) {
      var response = await getJournal(userId);

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
        appBar: backButtonAppbar(() => null, "Notes", secondaryColor),
        backgroundColor: secondaryColor,
        body: _isLoading
            ? LoadingScreen()
            : Column(
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
                          return JournalDisplay(
                            props: JournalProps(
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
