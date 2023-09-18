import 'package:flutter/material.dart';
import '../../utils/colours.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

AppBar backButtonAppbar(Function(), String appBarTitle) {
  return AppBar(
    centerTitle: true,
    backgroundColor: whiteColor,
    elevation: 0.0,
    title: Text(
      appBarTitle,
      style: TextStyle(
          color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    // actions: [
    //     GestureDetector(
    //       onTap: () {},
    //       child: Container(
    //         alignment: Alignment.center,
    //         width: 37,
    //         margin: EdgeInsets.all(10),
    //         child: SvgPicture.asset(
    //           "assets/icons/dots.svg",
    //           height: 5,
    //           width: 5,
    //         ),
    //         decoration: BoxDecoration(
    //             color: whiteColor, borderRadius: BorderRadius.circular(10)),
    //       ),
    //     )
    //   ],
    leading: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        child: SvgPicture.asset(
          "assets/icons/Arrow - Left 2.svg",
          height: 20,
          width: 20,
        ),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}
