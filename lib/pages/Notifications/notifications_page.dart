import 'package:flutter/material.dart';

import '../../components/displays/logged_appbar.dart';
import '../../components/displays/user_notification.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../Feed/feed_page.dart';
import '../Journal/journal_page.dart';
import '../Profile/profile_page.dart';
import '../Resources/resources_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _currentIndex = 4;

  final List<Widget> _pages = [
    const DashBoardPage(), // Replace with your dashboard content widget
    const JournalPage(),
    const ResourcesPage(),
    const FeedPage(),

    const NotificationContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: LoggedAppBar(alertButtonHandler: (){}, appBarTitle: "Notifications"),
          drawer: AppDrawer(),
        backgroundColor: secondaryColor,
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

class NotificationContent extends StatelessWidget {
  const NotificationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
         const Center(
            child: Text(
              "NO NEW NOTIFICATIONS",
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserNotification(
                  image: null,
                  name: "name",
                  Acceptclicky: () => {},
                  Declineclicky: () => {},
                ),
                UserNotification(
                  image: null,
                  name: "name",
                  Acceptclicky: () => {},
                  Declineclicky: () => {},
                ),
                UserNotification(
                  image: null,
                  name: "name",
                  Acceptclicky: () => {},
                  Declineclicky: () => {},
                ),
                UserNotification(
                  image: null,
                  name: "name",
                  Acceptclicky: () => {},
                  Declineclicky: () => {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
