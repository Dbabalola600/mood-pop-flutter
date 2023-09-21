import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/logged_appbar.dart';
import '../../components/displays/posts_display.dart';
import '../../components/inputs/search_bar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../models/user_post.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../Feed/feed_page.dart';
import '../Journal/journal_page.dart';
import '../Notifications/notifications_page.dart';

import 'dart:convert';
import '../Resources/resources_page.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashBoardContent(),
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

class DashBoardContent extends StatefulWidget {
  @override
  DashBoardContentState createState() => DashBoardContentState();
}

class UserIn {
  String? id;
  String? UserName;
  String? email;
  String? password;
  String? image;
  bool? isVerified;
  bool? isActive;
  String? role;

  UserIn({
    this.id,
    this.UserName,
    this.email,
    this.password,
    this.image,
    this.isVerified,
    this.isActive,
    this.role,
  });
}

class DashBoardContentState extends State<DashBoardContent> {
  bool _isLoading = false;
  String? username = "user";
  UserIn? user;

  List<Map<String, String>> postData = [];
  @override
  void initState() {
    super.initState();
    showInfo();
    loadSharedPreferences();
    // Call showInfo when the widget is inserted into the tree.
  }

  Future<void> loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
    });
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId") ?? "";
    // Assuming that getUserposts returns a JSON array as a string
    var response = await getUserposts(userId);
    //  print(response["data"]);

    List<dynamic> postData = response["data"];

    List<Widget> postWidgets = postData.map((post) {
      // Replace these placeholders with actual data from your JSON structure
      String content = post["category"];
      String date = post["date"];
      String name = post["post"];
      // String image = username?? "";

      return PostsDisplay(
        props: FeedProps(content: content, date: date, name: name),
      );
    }).toList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String textToCopy = "This is the text to be copied";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    //  user?.UserName ?? 'User',
                    username ?? "user",
                    style: const TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: textToCopy));
                  },
                  child: const Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Share Profile",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.share,
                        color: primaryColor,
                        size: 12,
                      ),
                    ],
                  ),
                )
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //   child: SvgPicture.asset(
          //     "assets/Empty/Blankcontent.svg",
          //     alignment: Alignment.center,
          //     width: 200,
          //     height: 300,
          //   ),
          // ),

          
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              :   ListView(
  children: postData.map((post) {
    return SizedBox(
      height: 100, // Replace with the actual height you want
      child: PostsDisplay(
        props: FeedProps(
          content: post["category"] ?? "",
          date: post["date"] ?? "",
          name: post["post"] ?? "",

        ),
      ),
    );
  }).toList(),
)

        ],
      ),
    );
  }
}
