import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../components/displays/app_button.dart';
import '../components/displays/basic_appbar.dart';
import '../utils/colours.dart';
import 'Start/login_page.dart';
import 'Start/signup_page.dart';






class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(appBarTitle: ""),
      body: 
      SingleChildScrollView(
        child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 120),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/logos/MoodLogo.svg",
                alignment: Alignment.center,
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Welome to Mood Pop",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: primaryColor,
                    fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: 2,
              ),
              const SizedBox(
                height: 2,
              ),
              AppButton(
                 buttonColour: primaryColor,
                  text: "Login", onPress: () => {Get.to(const LoginPage())}),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    RichText(
                      text: TextSpan(
                        text: "Sign Up",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: primaryColor,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(const SingUpPage()),
                      ),
                    ),
                  ],
                ),
              )
            ],),
      ),
      ),
     
    );
  }
}