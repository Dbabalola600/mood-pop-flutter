import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
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

  @override
  Widget build(BuildContext context) {
    void userLoginOnClick() async {
      _isLoading = true;
      var response = await loginUserWithUsernameAndPassword(
          loginIdController.text, passwordTextController.text);

      if (response["status"] == 200) {
        var userId = response["data"]["_id"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", userId);

        print(prefs.getString("userId"));
      } else {
        print("incorrect");
      }

      _isLoading = false;
    }

    void isTextFieldBlankValidation(String value) {
      if (loginIdController.text.isEmpty ||
          passwordTextController.text.isEmpty) {
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
      appBar: backButtonAppbar(() {}, "Welcome Back"),
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
                      text: const TextSpan(
                          text: "Forgot Password?",
                          style: TextStyle(color: blackColor)),
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
                      text: "Sign In",
                      onPress: userLoginOnClick,
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
                              text: "SignUp",
                              style: const TextStyle(color: successColor),
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
