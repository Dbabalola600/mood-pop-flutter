import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/displays/back_appbar.dart';
import '../../../components/displays/journal_display.dart';

import '../../../requests/auth_request.dart';
import '../../../utils/colours.dart';
import '../../components/displays/feed_display.dart';

class FullFeedPage extends StatefulWidget {
  const FullFeedPage({Key? key}) : super(key: key);
  @override
  State<FullFeedPage> createState() => _FullFeedPageState();
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

class _FullFeedPageState extends State<FullFeedPage> {
  bool _isLoading = false;
  String? username = "user";
  dynamic userImage = " ";
  List<FeedPosts> feedList = [];
  List<Map<String, String>> feedData = [];

  @override
  void initState() {
    super.initState();
    showInfo();

    // Call showInfo when the widget is inserted into the tree.
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await getfollowingposts(prefs.getString("userId"));

    if (response != null) {
      var feedData = response;
      // print("here"+postData);
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

    // print(journalList[0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: backButtonAppbar(() => null, "FEED", secondaryColor),
        backgroundColor: secondaryColor,
        body: Column(
          children: [
            if (feedList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SvgPicture.asset(
                  "assets/Empty/BlankNote.svg",
                  alignment: Alignment.center,
                  width: 100,
                  height: 300,
                ),
              ),
            if (feedList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: feedList.length,
                  itemBuilder: (context, index) {
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
              ),
          ],
        ),
      ),
    );
  }
}
