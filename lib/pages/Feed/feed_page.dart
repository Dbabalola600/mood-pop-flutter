import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/Buttons/oval_button.dart';
import '../../components/displays/feed_display.dart';
import '../../components/displays/logged_appbar.dart';

import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../Journal/journal_page.dart';
import '../Notifications/notifications_page.dart';

import '../Post/new_post.dart';
import '../Resources/resources_page.dart';
import '../Users/user_page.dart';
import 'full_feed_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class FeedPosts {
  final String userName;
  final String userImage;
  final String date;
  final String content;

  FeedPosts({
    required this.userName,
    required this.userImage,
    required this.date,
    required this.content,
  });
}

class _FeedPageState extends State<FeedPage> {
  int _currentIndex = 3;
  bool _isLoading = false;

  final List<Widget> _pages = [
    const DashBoardPage(),
    const JournalPage(), // Replace with your dashboard content widget
    const ResourcesPage(),

    const NotificationsPage(),
  ];

  List<FeedPosts> feedList = [];
  List<Map<String, String>> feedData = [];

  @override
  void initState() {
    super.initState();
    showInfo();
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await getfollowingposts(prefs.getString("userId"));
    // print(prefs.getString("image"));

    print(response[0]["post"]);

    if (response != null) {
      var feedData = response;

      feedList = (feedData as List).map((feed) {
        return FeedPosts(
            userName: feed["user"]["UserName"],
            userImage: feed["user"]["image"],
            date: feed["post"]["date"],
            content: feed["post"]["post"]);
      }).toList();
    }
    setState(() {
      _isLoading = false;
    });

    // return jsonDecode(response);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: LoggedAppBar(alertButtonHandler: () {}, appBarTitle: "Feed"),
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
        body: SingleChildScrollView(
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
                        onTap: () => Get.to(const NewPostPage()),
                        svgUrlString: "",
                        icon: const Icon(Icons.note_add)),
                    const Spacer(),
                    ovalButton(
                        name: "View Friends",
                        onTap: () => Get.to(const UsersPage()),
                        svgUrlString: "",
                        icon: const Icon(Icons.people_alt)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
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
                  const Spacer(),
                  GestureDetector(
                    onTap: () => {Get.to(const FullFeedPage())},
                    child: const Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.read_more,
                          color: primaryColor,
                          size: 12,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(_isLoading ? "loading..." : ""),
              Column(
                  children: feedList.length.toInt() == 0
                      ? [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SvgPicture.asset(
                              "assets/Empty/BlankFeed.svg",
                              alignment: Alignment.center,
                              width: 100,
                              height: 300,
                            ),
                          ),
                        ]
                      : [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                ListView.builder(
                                  itemCount:
                                      feedList.length > 3 ? 3 : feedList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, int index) {
                                    final info = feedList[index];

                                    return FeedDisplay(
                                      props: FeedProps(
                                          content: info.content,
                                          date: info.date,
                                          name: info.userName,
                                          image: info.userImage),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ]),
            ],
          ),
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
                    onTap: () => Get.to(const NewPostPage()),
                    svgUrlString: "",
                    icon: const Icon(Icons.note_add)),
                const Spacer(),
                ovalButton(
                    name: "View Friends",
                    onTap: () => Get.to(const UsersPage()),
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
          //   FeedDisplay(
          //       props: FeedProps(name: "name", date: "date", content: "content")),
          //   FeedDisplay(
          //       props: FeedProps(name: "name", date: "date", content: "content")),
          //   FeedDisplay(
          //       props: FeedProps(name: "name", date: "date", content: "content")),
          //   FeedDisplay(
          //       props: FeedProps(name: "name", date: "date", content: "content")),
        ],
      ),
    );
  }
}
