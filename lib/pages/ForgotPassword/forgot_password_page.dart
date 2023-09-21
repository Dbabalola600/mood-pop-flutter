import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../components/navigation/app_drawer.dart';

import '../../utils/colours.dart';
import 'forgot_password_token_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  bool isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    void isTextFieldBlankValidation() {
      if (emailController.text.isEmpty) {
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
        appBar: backButtonAppbar(() {}, "Forgot Password", secondaryColor),
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
                    "Enter Email address associated with your account",
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  AppTextField(
                    label: "Email",
                    hint: "Email",
                    textInputType: TextInputType.emailAddress,
                    // key: Key(1.toString()),
                    textController: emailController,
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
                            {Get.to(const ForgotPasswordTokenPage())},
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
