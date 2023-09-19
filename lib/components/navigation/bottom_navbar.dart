import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/DashBoard/dash_board_page.dart';
import '../../pages/Feed/feed_page.dart';
import '../../pages/Journal/journal_page.dart';
import '../../pages/Notifications/notifications_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/Resources/resources_page.dart';
import '../../utils/colours.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.to(const DashBoardPage()); // Navigate to the home page
            break;
          case 1:
            Get.to(const JournalPage()); // Navigate to the notifications page
            break;
          case 2:
            Get.to(const ResourcesPage()); // Navigate to the profile page
            break;
          case 3:
            Get.to(const FeedPage()); // Navigate to the profile page
            break;
          case 4:
            Get.to(const NotificationsPage()); // Navigate to the profile page
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'DashBoard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Journal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.health_and_safety),
          label: 'Resources',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feedback_rounded),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Norifications',
        ),
      ],
      backgroundColor: disabledColor,
      selectedItemColor: primaryColor, // Customize the selected item color
      unselectedItemColor: blackColor, // Customize the unselected item color

      showUnselectedLabels:
          false, // Set to true to show labels for unselected items
      type:
          BottomNavigationBarType.fixed, // Use fixed type for more than 3 items

      // You can also add additional properties and customization here
    );
  }
}
