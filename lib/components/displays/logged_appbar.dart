import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../pages/Settings/settings_page.dart';
import '../../utils/colours.dart';

AppBar loggedAppBar(Function() alertButtonHandler, String appBarTitle) {
  return AppBar(
    elevation: 0,
    backgroundColor: secondaryColor,
    toolbarHeight: 80,
    centerTitle: true,
    title: Text(
      appBarTitle,
      style: TextStyle(
          color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Builder(builder: (context) {
        return IconButton(
          // icon: SizedBox(
          //   height: 15,
          //   width: 15,
          //   child: SvgPicture.asset(
          //     "assets/icons/menuNav.svg",
          //     fit: BoxFit.cover,
          //   ),
          // ),
          icon: const Icon(Icons.person, color: blackColor,),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.settings  ,color: blackColor),
        onPressed:()=> Get.to(const SettingsPage()),
      ),
      const SizedBox(
        width: 18,
      ),
    ],
  );
}
