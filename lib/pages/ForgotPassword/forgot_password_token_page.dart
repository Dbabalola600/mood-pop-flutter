import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../components/navigation/app_drawer.dart';

import '../../utils/colours.dart';
import 'reset_password_page.dart';

class ForgotPasswordTokenPage extends StatefulWidget {
  const ForgotPasswordTokenPage({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordTokenPage> createState() =>
      _ForgotPasswordTokenPageState();
}

class _ForgotPasswordTokenPageState extends State<ForgotPasswordTokenPage> {
  final passwordController = TextEditingController();
  bool isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    void isTextFieldBlankValidation() {
      if (passwordController.text.isEmpty) {
        setState(() {
          isButtonDisabled = true;
        });
      } else {
        setState(() {
          isButtonDisabled = false;
        });
      }
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar:
            backButtonAppbar(() {}, "Forgot Password token", secondaryColor),
        backgroundColor: secondaryColor,
        drawer: AppDrawer(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Enter token sent to your Email address ",
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  AppTextField(
                    label: "Token",
                    hint: "Token",
                    // textInputType: TextInputType.emailAddress,
                    // key: Key(1.toString()),
                    textController: passwordController,
                    onChanged: (text) {
                      isTextFieldBlankValidation();
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppButton(
                         buttonColour: primaryColor,
                        text: "Proceed",
                        onPress: () =>
                            {Get.to(const ResetPasswordPage())},
                        // isDisabled: isButtonDisabled,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
