import 'package:flutter/material.dart';


import '../../components/displays/logged_appbar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../Feed/feed_page.dart';
import '../Notifications/notifications_page.dart';
import '../Profile/profile_page.dart';
import '../Resources/resources_page.dart';




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

class JournalContent extends StatelessWidget {
  const JournalContent({super.key});

  @override
  Widget build(BuildContext context) {

    return const Center(
        child: Text(
      "Jounral",
      style: TextStyle(fontSize: 30, color: primaryColor),
    ));
  }
}
