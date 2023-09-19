import 'package:flutter/material.dart';

import '../../components/displays/logged_appbar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../Notifications/notifications_page.dart';
import '../Profile/profile_page.dart';

class WriteJournalPage extends StatefulWidget {
  const WriteJournalPage({Key? key}) : super(key: key);
  @override
  State<WriteJournalPage> createState() => _WriteJournalPageState();
}

class _WriteJournalPageState extends State<WriteJournalPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashBoardContent(), // Replace with your dashboard content widget
    const NotificationsPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: loggedAppBar(() {}, "WriteJournalPage"),
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

class DashBoardContent extends StatelessWidget {
  const DashBoardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "WriteJournalPage",
      style: TextStyle(fontSize: 30, color: primaryColor),
    ));
  }
}
