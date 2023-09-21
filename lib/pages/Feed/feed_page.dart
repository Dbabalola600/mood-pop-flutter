import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';



import '../../components/displays/Buttons/oval_button.dart';
import '../../components/displays/feed_display.dart';
import '../../components/displays/logged_appbar.dart';

import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../Journal/journal_page.dart';
import '../Notifications/notifications_page.dart';

import '../Post/new_post.dart';
import '../Resources/resources_page.dart';
import '../Users/user_page.dart';

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

class FeedContent extends StatelessWidget {
  const FeedContent({super.key});

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
                  name: "New post",
                  onTap: () => Get.to(const NewPostPage ()),
                  svgUrlString: "",
                  icon: const Icon(Icons.note_add)),
              const Spacer(),
              ovalButton(
                  name: "View Friends",
                  onTap: () => Get.to(const UsersPage ()),
                  svgUrlString: "",
                  icon: const Icon(Icons.people_alt)),
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
                  "Your Feed",
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
            "assets/Empty/BlankFeed.svg",
            alignment: Alignment.center,
            width: 100,
            height: 300,
          ),
        ),

        FeedDisplay(props: FeedProps(name: "name", date: "date", content: "content")),
         FeedDisplay(props: FeedProps(name: "name", date: "date", content: "content")),
             FeedDisplay(props: FeedProps(name: "name", date: "date", content: "content")),
                     FeedDisplay(props: FeedProps(name: "name", date: "date", content: "content")),
      ],
    ));
  }
}
