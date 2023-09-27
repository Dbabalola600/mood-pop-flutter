import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/displays/load_screen.dart';
import '../../components/displays/user_search_result.dart';
import '../../components/inputs/search_bar.dart';
import '../../components/navigation/app_drawer.dart';

import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import 'followers_page.dart';
import 'following_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class Followers {
  final String username;
  final String userImage;
  final String userId;

  Followers(
      {required this.username, required this.userImage, required this.userId});
}

class Following {
  final String username;
  final String userImage;
  final String userId;

  Following(
      {required this.username, required this.userImage, required this.userId});
}

class _UsersPageState extends State<UsersPage> {
  bool _isLoading = false;

  List<Followers> followerList = [];
  List<Map<String, String>> followerData = [];

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
    var follwingResponse = await getFollowing(prefs.getString("userId"));

    if (follwingResponse != null) {
      var followingData = follwingResponse;
      // print("here"+postData);
      followingList = (followingData as List).map((follow) {
        return Following(
            username: follow["UserName"],
            userImage: follow["image"],
            userId: follow["_id"]);
      }).toList();
    }

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
        appBar: backButtonAppbar(() {}, "Users ", secondaryColor),
        backgroundColor: secondaryColor,
        drawer: AppDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: 
             _isLoading
              ? LoadingScreen()
              : 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CustomSearchBar(
                            onSearch: (query) {},
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        //following

                        Row(
                          children: [
                            Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Following",
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 18),
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
                              onTap: () => {Get.to(FollowingPage())},
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
                        Column(
                          children: followingList.length.toInt() == 0
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: SvgPicture.asset(
                                      "assets/Empty/People2.svg",
                                      alignment: Alignment.center,
                                      width: 100,
                                      height: 200,
                                    ),
                                  ),
                                ]
                              : [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          itemCount: followingList.length > 3
                                              ? 3
                                              : followingList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, int index) {
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
                                      ],
                                    ),
                                  ),
                                ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //followers
                        Row(
                          children: [
                            Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Follwers",
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 18),
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
                              onTap: () => {Get.to(FollowersPage())},
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
                        Column(
                            children: followerList.length.toInt() == 0
                                ? [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: SvgPicture.asset(
                                        "assets/Empty/People2.svg",
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 200,
                                      ),
                                    ),
                                  ]
                                : [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          itemCount: followerList.length > 3
                                              ? 3
                                              : followerList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, int index) {
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
                                      ],
                                    ),
                                  ),
                                ]),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
