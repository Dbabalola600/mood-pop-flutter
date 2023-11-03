import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/app_alert_dialogue.dart';
import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../components/navigation/app_drawer.dart';

import '../../requests/auth_request.dart';
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
  bool _isLoading = false;
  bool showError = false;

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialogue(
          title: 'Error ',
          content: 'Incorrect email',
          contentColor: primaryColor,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  showError = false; // Set showError to false when closing
                });
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

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

  void userLoginOnClick() async {
    setState(() {
      _isLoading = true;
    });

    var response = await resetPasswordTokenSend(emailController.text);

    // print(response);

    if (response["status"] == 200) {
      var userId = response["data"]["userId"];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("TempUserId", userId);


      Get.to( const ForgotPasswordTokenPage());
    } else {
      setState(() {
        showError = true;
      });
      // ignore: use_build_context_synchronously
      showLoginErrorDialog(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: backButtonAppbar(() {}, "Forgot Password", secondaryColor),
        backgroundColor: secondaryColor,
        drawer: const AppDrawer(),
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
                        text: _isLoading ? "Loading..." : "Proceed",
                        onPress: userLoginOnClick,
                        isDisabled: isButtonDisabled,
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
