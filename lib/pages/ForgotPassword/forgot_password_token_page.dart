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
import 'reset_password_page.dart';

class ForgotPasswordTokenPage extends StatefulWidget {
  const ForgotPasswordTokenPage({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordTokenPage> createState() =>
      _ForgotPasswordTokenPageState();
}

class _ForgotPasswordTokenPageState extends State<ForgotPasswordTokenPage> {
  final tokenController = TextEditingController();
  bool isButtonDisabled = true;
  bool _isLoading = false;
  bool showError = false;
  String? userId = " ";

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();

  }

  Future<void> loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("TempUserId");
    });
  }

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialogue(
          title: 'Error ',
          content: 'Incorrect Token',
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
    if (tokenController.text.isEmpty) {
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



    var response = await validateResetPasswordToken(
      userId: userId,
      token: tokenController.text
    );

    // print(response);

    if (response["status"] == 200) {

      Get.to(const ResetPasswordPage());
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
                    textController: tokenController,
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
