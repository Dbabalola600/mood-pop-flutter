import '../../utils/colours.dart';

import 'package:flutter/material.dart';


  @override
  AppBar BasicAppBar( {Function()?, String appBarTitle =""} ) {
    return AppBar(
      centerTitle: true,
    backgroundColor: whiteColor,
    elevation: 0,
    title: Text(appBarTitle,
    style: TextStyle(
      color: primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold
    ),
    ),
    );
  }
