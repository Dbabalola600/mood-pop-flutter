import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mood_pop/components/displays/user_search_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/back_appbar.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);
  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class Following {
  final String username;
  final String userImage;
  final String userId;

  Following(
      {required this.username, required this.userImage, required this.userId});
}

class _FollowingPageState extends State<FollowingPage> {
  bool _isLoading = false;

  List<Following> followingList = [];
  List<Map<String, String>> followingData = [];

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

    var follwerResponse = await getFollowing(prefs.getString("userId"));
    if (follwerResponse != null) {
      var followerData = follwerResponse;
      // print("here"+postData);
      followingList = (followerData as List).map((follow) {
        return Following(
            username: follow["UserName"],
            userImage: follow["image"],
            userId: follow["_id"]);
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
        appBar: backButtonAppbar(() => null, "Following", secondaryColor),
        backgroundColor: secondaryColor,
        body: Column(
          children: [
            if (followingList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SvgPicture.asset(
                  "assets/Empty/People1.svg",
                  alignment: Alignment.center,
                  width: 100,
                  height: 200,
                ),
              ),
            if (followingList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: followingList.length,
                  itemBuilder: (context, index) {
                    final info = followingList[index];
                    return UserSearchResult(
                      props: UserSearchProps(
                          image: info.userImage,
                          name: info.username,
                          clicky: () {},
                          cilckyText: "Remove"),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
