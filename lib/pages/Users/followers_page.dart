import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/displays/user_search_result.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key}) : super(key: key);
  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class Followers {
  final String username;
  final String userImage;
  final String userId;

  Followers(
      {required this.username, required this.userImage, required this.userId});
}

class _FollowersPageState extends State<FollowersPage> {
  bool _isLoading = false;

  List<Followers> followerList = [];
  List<Map<String, String>> followerData = [];

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

    var follwerResponse = await getFollowers(prefs.getString("userId"));
    if (follwerResponse != null) {
      var followerData = follwerResponse;
      // print("here"+postData);
      followerList = (followerData as List).map((follow) {
        return Followers(
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
        appBar: backButtonAppbar(() => null, "Followers", secondaryColor),
        backgroundColor: secondaryColor,
        body: Column(
          children: [
            if (followerList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SvgPicture.asset(
                  "assets/Empty/People2.svg",
                  alignment: Alignment.center,
                  width: 100,
                  height: 200,
                ),
              ),
            if (followerList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: followerList.length,
                  itemBuilder: (context, index) {
                    final info = followerList[index];
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
