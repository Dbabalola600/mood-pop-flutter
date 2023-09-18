import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../utils/colours.dart';

AppBar loggedAppBar(Function() alertButtonHandler) {
  return AppBar(
    elevation: 0,
    backgroundColor: whiteColor,
    toolbarHeight: 80,
    leading: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Builder(builder: (context) {
        return IconButton(
          icon: SizedBox(
            height: 15,
            width: 15,
            child: SvgPicture.asset(
              "assets/icons/menuNav.svg",
              fit: BoxFit.cover,
            ),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
    ),
    actions: [
      IconButton(
        icon: SvgPicture.asset(
          "assets/icons/alertNav.svg",
          height: 20,
        ),
        onPressed: alertButtonHandler,
      ),
      const SizedBox(
        width: 18,
      ),
    ],
  );
}
