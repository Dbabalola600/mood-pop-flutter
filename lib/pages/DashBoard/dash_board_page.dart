

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/logged_appbar.dart';
import '../../components/displays/posts_display.dart';
import '../../components/inputs/search_bar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';

import '../../requests/auth_request.dart';
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
              child: ListView.builder(
                itemCount:
                    1, // Since you have a single page, set itemCount to 1
                itemBuilder: (context, index) {
                  return _pages[_currentIndex]; // Display the selected page
                },
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

class Posts {
  final String userId;
  final String post;
  final String category;
  final String date;

  Posts({
    required this.userId,
    required this.post,
    required this.category,
    required this.date,
  });
}

class DashBoardContentState extends State<DashBoardContent> {
  bool _isLoading = false;
  String? username = "user";
  UserIn? user;
  List<Posts> postList = [];

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
    var response = await getUserposts(prefs.getString("userId"));
    // print(response);

    if (response != null) {
      var postData = response;
      // print("here"+postData);
      postList = (postData as List).map((post) {
        return Posts(
          userId: post["userId"],
          post: post["post"],
          category: post["category"],
          date: post["date"],
        );
      }).toList();
    }
    setState(() {
      _isLoading = false;
    });

    // return jsonDecode(response);
    
  }

  @override
  Widget build(BuildContext context) {
    String textToCopy = "This is the text to be copied";

    return Column(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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

        // Your existing code here

        // ListView.builder(
        //   itemCount: postList.length,
        //   shrinkWrap: true,
        //   itemBuilder: (context, int index) {
        //     final info = postList[index];

        //     return SizedBox(
        //       // width: 300, // Set width as needed
        //       // height: 300,
        //       // Add styling here if needed
        //       child: PostsDisplay(
        //         props: FeedProps(
        //           content: info.category,
        //           date: info.date,
        //           name: username ?? "user",
        //         ),
        //       ),
        //     );
        //   },
        // ),

        Column(
          children: postList.length.toInt() == 0
              ? [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SvgPicture.asset(
                      "assets/Empty/Blankcontent.svg",
                      alignment: Alignment.center,
                      width: 200,
                      height: 300,
                    ),
                  ),
                ]
              : [
                  ListView.builder(
                    itemCount: postList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      final info = postList[index];

                      return PostsDisplay(
                        props: FeedProps(
                          content: info.category,
                          date: info.date,
                          name: username ?? "user",
                        ),
                      );
                    },
                  ),
                ],
        ),
      ]),
    ]);
  }
}
