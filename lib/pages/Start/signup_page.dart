
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../utils/colours.dart';
import 'package:get/get.dart';

import 'login_page.dart';



class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final passwordTextController = TextEditingController();

  final userNameController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  // page state
  bool isButtonDisabled = true;
  @override
  Widget build(BuildContext context) {
    void isTextFieldBlankValidation() {
      if (userNameController.text.isEmpty ||
          passwordTextController.text.isEmpty ||
          confirmPasswordTextController.text.isEmpty) {
        setState(() {
          isButtonDisabled = true;
        });
      } else {
        setState(() {
          isButtonDisabled = false;
        });
      }
    }

    return Scaffold(
      appBar: backButtonAppbar(() {}, "Create Account", whiteColor),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    SvgPicture.asset("assets/logos/mood.svg",
                        semanticsLabel: 'Mood Logo'),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Use your email address, phone number or account number as your login id",
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      label: "UserName",
                      hint: "username",
                      // key: Key(1.toString()),
                      textController: userNameController,
                      onChanged: (text) {
                        isTextFieldBlankValidation();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      hint: "***************",
                      label: "Enter Password",
                      textController: passwordTextController,
                      onChanged: (text) {
                        isTextFieldBlankValidation();
                      },
                      hideText: true,
                      // validator: ValidationBuilder().minLength(8).build(),
                    ),
                      const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      label: "Password",
                      hint: "***********",
                      key: Key(2.toString()),
                      textController: passwordTextController,
                      onChanged: (text) {
                        isTextFieldBlankValidation();
                      },
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      text: "Create Account",
                      onPress: () => {Get.to(const LoginPage())},
                       buttonColour: primaryColor,
                      // isDisabled: isButtonDisabled,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(color: blackColor),
                            ),
                            TextSpan(
                              text: "Login",
                              style: const TextStyle(color: primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(const LoginPage());
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}