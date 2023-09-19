import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../components/displays/logged_appbar.dart';
import '../../components/inputs/search_bar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../Feed/feed_page.dart';
import '../Journal/journal_page.dart';
import '../Notifications/notifications_page.dart';
import '../Profile/profile_page.dart';
import '../Resources/resources_page.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashBoardContent(),
    const JournalPage(), // Replace with your dashboard content widget
    const ResourcesPage(),
    const FeedPage(),
    const NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: loggedAppBar(() {}, "DASHBOARD"),
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
    String textToCopy = "This is the text to be copied";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal margin
          child: Row(
            children: [
              const Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  "Hi User",
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                  ),
                ),
              ),
              const Spacer(), // Add a spacer to create space between the texts
              const Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  "Share Profile ",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor, // You can customize the color
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: textToCopy));
                },
                child: const Icon(
                  Icons.share,
                  color: primaryColor,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
     const  SizedBox(
          height: 10,
        ),
        Center(
          child: CustomSearchBar(
            onSearch: (query) {},
          ),
        )
      ],
    );
  }
}
