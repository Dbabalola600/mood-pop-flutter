import 'package:flutter/material.dart';

import '../../components/displays/logged_appbar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../Journal/journal_page.dart';
import '../Notifications/notifications_page.dart';
import '../Profile/profile_page.dart';
import '../Resources/resources_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _currentIndex = 3;

  final List<Widget> _pages = [
    const DashBoardPage(),
    const JournalPage(), // Replace with your dashboard content widget
    const ResourcesPage(),
    const FeedContent(),
    const NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: loggedAppBar(() {}, "Feed"),
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
            _pages[_currentIndex], // Display the selected page
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

class FeedContent extends StatelessWidget {
  const FeedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "Feed",
      style: TextStyle(fontSize: 30, color: primaryColor),
    ));
  }
}
