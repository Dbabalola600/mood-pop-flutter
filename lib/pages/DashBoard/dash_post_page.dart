import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/posts_display.dart';
import '../../requests/auth_request.dart';

class DashBoardPostPage extends StatefulWidget {
  const DashBoardPostPage({Key? key}) : super(key: key);
  @override
  State<DashBoardPostPage> createState() => _DashBoardPostPageState();
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

class _DashBoardPostPageState extends State<DashBoardPostPage> {
  bool _isLoading = false;
  String? username = "user";
  dynamic userImage = " ";
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
      userImage = prefs.getString("image");
    });
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await getUserposts(prefs.getString("userId"));
    // print(prefs.getString("image"));

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
    String base64ImageWithPrefix = userImage;

    // Remove the prefix and decode the base64 string into bytes
    String base64Image = base64ImageWithPrefix.split(',').last;
    Uint8List uint8List = base64.decode(base64Image);
    Image image = Image.memory(
      uint8List,
      fit: BoxFit.contain, // You can set the fit as needed
    );

    return Column(
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
                      image: userImage
                    ),
                  );
                },
              ),
            ],
    );
  }
}
