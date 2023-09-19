import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../pages/Notifications/notifications_page.dart';
import '../../pages/Profile/profile_page.dart';
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
                    name: "New Post",
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
                    name: "Seek Help",
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
                    name: "Notification" ,
                    
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
                        name: "Logout",
                        svgUrl: "assets/icons/drawerLogout.svg",
                        onClickHandler: () => {},
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
    required this.onClickHandler,
  }) : super(key: key);

  final String name;
  final String svgUrl;
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
              name == "Profile"
                  ? const SizedBox(width: 2)
                  : const SizedBox(
                      width: 0,
                    ),
              SvgPicture.asset(
                svgUrl,
              ),
              const SizedBox(
                width: 10,
              ),
              name == "Profile"
                  ? const SizedBox(width: 3)
                  : const SizedBox(
                      width: 0,
                    ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
