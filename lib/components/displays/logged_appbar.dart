import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/Settings/settings_page.dart';
import '../../utils/colours.dart';

class LoggedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function() alertButtonHandler;
  final String appBarTitle;

  LoggedAppBar({required this.alertButtonHandler, required this.appBarTitle});

  @override
  _StatefulAppBarState createState() => _StatefulAppBarState();

  @override
  // TODO: implement preferredSize

  Size get preferredSize => Size.fromHeight(80);
}

class _StatefulAppBarState extends State<LoggedAppBar> {
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

    return AppBar(
      elevation: 0,
      backgroundColor: secondaryColor,
      toolbarHeight: 80,
      centerTitle: true,
      title: Text(
        widget.appBarTitle,
        style: TextStyle(
          color: primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Builder(builder: (context) {
          return IconButton(
            icon: uint8List != null && uint8List.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.memory(
                        uint8List,
                        fit: BoxFit
                            .cover, // Use BoxFit.cover to fill the container
                      ),
                    ),
                  )
                : const Icon(
                    Icons.person,
                    color: blackColor,
                  ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: blackColor),
          onPressed: () => Get.to(const SettingsPage()),
        ),
        const SizedBox(
          width: 18,
        ),
      ],
    );
  }
}
