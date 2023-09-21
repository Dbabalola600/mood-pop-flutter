import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../Start/login_page.dart';


class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
        appBar: backButtonAppbar(() {}, "Reset password", secondaryColor),
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
                    "Enter new account password",
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  AppTextField(
                    label: "New Password",
                    hint: "New Password",
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
                            {Get.to(const LoginPage())},
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
