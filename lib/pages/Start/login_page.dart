import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/app_alert_dialogue.dart';
import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';
import '../../components/displays/basic_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../ForgotPassword/forgot_password_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordTextController = TextEditingController();

  final loginIdController = TextEditingController();

  // page state
  bool isButtonDisabled = true;
  bool _isLoading = false;

  bool showError = false;

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialogue(
          title: 'Error Logging in',
          content: 'Incorrect email or password',
          contentColor: primaryColor,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  showError = false; // Set showError to false when closing
                });
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void userLoginOnClick() async {
    setState(() {
      _isLoading = true;
    });
    var response = await loginUserWithUsernameAndPassword(
        loginIdController.text, passwordTextController.text);

    if (response["status"] == 200) {
      var userId = response["data"]["_id"];
      var email = response["data"]["email"];
      var username = response["data"]["UserName"];
      var image = response["data"]["image"];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", userId);
      prefs.setString("email", email);
      prefs.setString("username", username);
      prefs.setString("image", image);
      // print(prefs.getString("userId"));

      Get.to(const DashBoardPage());
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

  void isTextFieldBlankValidation(String value) {
    if (loginIdController.text.isEmpty || passwordTextController.text.isEmpty) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(() {}, "Welcome Back", whiteColor),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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


                    

                      

                    const Text(
                      "Use your email address or username and password",
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      label: "UserName/Email",
                      hint: "username/email",
                      key: Key(1.toString()),
                      textController: loginIdController,
                      onChanged: isTextFieldBlankValidation,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      label: "Password",
                      hint: "***********",
                      key: Key(2.toString()),
                      textController: passwordTextController,
                      onChanged: isTextFieldBlankValidation,
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Forgot Password?",
                            style: const TextStyle(color: primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Get.to(const ForgotPasswordPage()),
                          ),
                        ],
                      ),
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
                      text: _isLoading ? "Loading..." : "Sign In",
                      onPress: userLoginOnClick,
                      buttonColour: primaryColor,
                      isDisabled: isButtonDisabled,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: blackColor),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: const TextStyle(color: primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(const SingUpPage()),
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
