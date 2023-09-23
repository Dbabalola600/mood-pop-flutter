import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mood_pop/requests/auth_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/Buttons/oval_button.dart';
import '../../components/displays/journal_display.dart';
import '../../components/displays/logged_appbar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../Feed/feed_page.dart';
import '../Notifications/notifications_page.dart';

import '../Resources/resources_page.dart';
import 'record_journal.dart';
import 'write_journal.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);
  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const DashBoardPage(),
    JournalContent(), // Replace with your dashboard content widget
    const ResourcesPage(),
    const FeedPage(),
    const NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: loggedAppBar(() {}, "Journal"),
          backgroundColor: secondaryColor,
          drawer: AppDrawer(),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount:
                      1, // Since you have a single page, set itemCount to 1
                  itemBuilder: (context, index) {
                    return _pages[_currentIndex]; // Display the selected page
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ],
          ),
        ));
  }
}

class JournalContent extends StatefulWidget {
  @override
  JournalContentState createState() => JournalContentState();
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

class JournalContentState extends State<JournalContent> {
  bool _isLoading = false;
  List<Journals> journalList = [];
  List<Map<String, String>> journalData = [];

  @override
  void initState() {
    super.initState();
    showInfo();
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
    return Column(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ovalButton(
                    name: "Write journal",
                    onTap: () => Get.to(const WriteJournalPage()),
                    svgUrlString: "",
                    icon: const Icon(Icons.bookmark_add_sharp)),
                const Spacer(),
                ovalButton(
                    name: "Record journal",
                    onTap: () => Get.to(const RecordJournalPage()),
                    svgUrlString: "",
                    icon: const Icon(Icons.record_voice_over)),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Notes",
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  height: 4,
                  width: 120,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          // Text(journalList[0].content),
          Column(
            children: journalList.length.toInt() == 0
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SvgPicture.asset(
                        "assets/Empty/BlankNote.svg",
                        alignment: Alignment.center,
                        width: 100,
                        height: 300,
                      ),
                    ),
                  ]
                : [
                    ListView.builder(
                        itemCount: journalList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final info = journalList[index];
                          return JournalDisplay(
                            props: JournalProps(
                                date: info.date, title: info.title),
                          );
                        })
                  ],
          ),

          const SizedBox(
            height: 15,
          ),
        ],
      )
    ]);
  }
}
