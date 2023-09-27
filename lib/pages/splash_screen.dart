
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../main.dart';
import '../utils/colours.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}



class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Center(child: SvgPicture.asset("assets/logos/MoodLogo.svg")),
      decoration: const BoxDecoration(
        color: blackColor,
        image: DecorationImage(
          image: AssetImage("assets/images/MoodLogo.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
