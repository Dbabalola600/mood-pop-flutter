import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mood_pop/components/displays/posts_display.dart';

import '../../components/displays/logged_appbar.dart';
import '../../components/inputs/search_bar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../Feed/feed_page.dart';
import '../Journal/journal_page.dart';
import '../Notifications/notifications_page.dart';

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
        appBar: loggedAppBar(() {}, ""),
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
      ),
    );
  }
}

//make this whole thing scrollable
class DashBoardContent extends StatelessWidget {
  const DashBoardContent({super.key});

  @override
  Widget build(BuildContext context) {
    String textToCopy = "This is the text to be copied";
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hi User",
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Share Profile ",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
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
          const SizedBox(
            height: 10,
          ),
          Center(
            child: CustomSearchBar(
              onSearch: (query) {},
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your posts",
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
              "assets/Empty/Blankcontent.svg",
              alignment: Alignment.center,
              width: 200,
              height: 300,
            ),
          ),

          // Rest of your content here...
          PostsDisplay(
            props: FeedProps(
              image: "",
              name: "NAME",
              date: "date",
              content: "content",
            ),
          ),
          PostsDisplay(
            props: FeedProps(
              image: "",
              name: "NAME",
              date: "date",
              content:
                  "conoiwwuobuveobvosiponvsiv sinvosivbpsoinv0s soivnsvn0iv0nv winvw0nveivbe9uvbesoinvsvbn9usvnb wonvuuv9bn9uvbe9buvobeve0vb woinvw9vbeu9vovn  wiofw0ubf oinw0unvtent",
            ),
          ),
          PostsDisplay(
            props: FeedProps(
              image: "",
              name: "NAME",
              date: "date",
              content: "content",
            ),
          ),
          PostsDisplay(
            props: FeedProps(
              image: "",
              name: "NAME",
              date: "date",
              content: "content",
            ),
          ),
          PostsDisplay(
            props: FeedProps(
              image: "",
              name: "NAME",
              date: "date",
              content: "content",
            ),
          ),
          PostsDisplay(
            props: FeedProps(
              image: "",
              name: "NAME",
              date: "date",
              content: "content",
            ),
          ),
        ],
      ),
    );
  }
}
