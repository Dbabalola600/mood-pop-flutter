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
      backgroundColor: whiteColor,
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
              ),
              const SizedBox(
                height: 50,
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
                    name: "Notifications",
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
