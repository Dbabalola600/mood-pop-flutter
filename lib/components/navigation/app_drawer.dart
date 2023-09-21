import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';



import '../../pages/Journal/write_journal.dart';
import '../../pages/Notifications/notifications_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/Start/login_page.dart';
import '../../utils/colours.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: disabledColor,


      width: 200,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //user image and name goes in here
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: Icon(Icons.person, color: primaryColor, size: 80),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text("NAME"),
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
                    svgUrl:"",
                    icon:  Icons.person,
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
                          builder: (context) => const ProfilePage(),
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
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                 
                  DrawerNavButtons(
                    name: "Friends" ,
                    icon: Icons.people_alt,
                    svgUrl: "",
                    onClickHandler: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsPage(),
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
                        icon:Icons.logout,
                        name: "Logout",
                        svgUrl: "",
                        onClickHandler: () => Get.to(const LoginPage()),
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
                      width: 10, height: 40,
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
