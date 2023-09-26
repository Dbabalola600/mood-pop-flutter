import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/Journal/write_journal.dart';

import '../../pages/Post/new_post.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/Resources/seek_help_page.dart';
import '../../pages/Start/login_page.dart';
import '../../pages/Users/user_page.dart';
import '../../utils/colours.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  _StatefulAppBarState createState() => _StatefulAppBarState();
}

class _StatefulAppBarState extends State<AppDrawer> {
  String? username = "user";
  dynamic userImage = " ";

  @override
  void initState() {
    super.initState();
    // showInfo();
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

  void userLogoutClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
    Get.to(const LoginPage());
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

    return Drawer(
      backgroundColor: disabledColor,
      width: 200,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //user image and name goes in here
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: (uint8List != null && uint8List.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Image.memory(
                                uint8List!,
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to fill the container
                              ),
                            ),
                          )
                        : Icon(Icons.person, color: primaryColor, size: 80),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(username ?? ""),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  DrawerNavButtons(
                    name: "Profile",
                    svgUrl: "",
                    icon: Icons.person,
                    onClickHandler: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                  DrawerNavButtons(
                    name: "New Post",
                    icon: Icons.note_add,
                    svgUrl: "",
                    onClickHandler: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPostPage(),
                        ),
                      );
                    },
                  ),
                  DrawerNavButtons(
                    name: "New Journal",
                    icon: Icons.bookmark_add_sharp,
                    svgUrl: "",
                    onClickHandler: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WriteJournalPage(),
                        ),
                      );
                    },
                  ),
                  DrawerNavButtons(
                    name: "Seek Help",
                    icon: Icons.handshake,
                    svgUrl: "",
                    onClickHandler: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SeekHelpPage(),
                        ),
                      );
                    },
                  ),
                  DrawerNavButtons(
                    name: "Friends",
                    icon: Icons.people_alt,
                    svgUrl: "",
                    onClickHandler: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UsersPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      DrawerNavButtons(
                        icon: Icons.logout,
                        name: "Logout",
                        svgUrl: "",
                        onClickHandler: userLogoutClick,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerNavButtons extends StatelessWidget {
  const DrawerNavButtons({
    Key? key,
    required this.name,
    required this.svgUrl,
    required this.icon,
    required this.onClickHandler,
  }) : super(key: key);

  final String name;
  final String svgUrl;
  final dynamic icon;
  final VoidCallback onClickHandler;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickHandler,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Ink(
          child: Row(
            children: [
              Icon(icon),
              SvgPicture.asset(
                svgUrl,
              ),
              // const SizedBox(
              //   width: 10,
              // ),
              const SizedBox(
                width: 10,
                height: 40,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
