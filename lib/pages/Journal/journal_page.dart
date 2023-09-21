import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


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
    const JournalContent(), // Replace with your dashboard content widget
    const ResourcesPage(),
    const FeedPage(),
    const NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: loggedAppBar(() {}, "Jounral"),
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
              child: SingleChildScrollView(
                child: _pages[_currentIndex], // Display the selected page
              ),
            ), // Display the selected page
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JournalContent extends StatelessWidget {
  const JournalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SvgPicture.asset(
            "assets/Empty/BlankNote.svg",
            alignment: Alignment.center,
            width: 100,
            height: 300,
          ),
        ),
        JournalDisplay(props: JournalProps(title: "title", date: "date")),
        JournalDisplay(props: JournalProps(title: "title", date: "date")),
        JournalDisplay(props: JournalProps(title: "title", date: "date")),
        JournalDisplay(props: JournalProps(title: "title", date: "date")),
      ],
    ));
  }
}
