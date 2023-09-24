import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/app_button.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';

class UpdateUsernamePage extends StatefulWidget {
  const UpdateUsernamePage({Key? key}) : super(key: key);

  @override
  State<UpdateUsernamePage> createState() => _UpdateUsernamePageState();
}

class _UpdateUsernamePageState extends State<UpdateUsernamePage> {
  final usernameController = TextEditingController();
  // page state
  bool isButtonDisabled = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    void userUpdateOnClick() async {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var response = await updateUsername(
          UserName: usernameController.text, id: prefs.getString("userId"));
      print(response.toString());
      if (response["status"].toString() == "200") {
        prefs.setString("username", usernameController.text);
        Get.to(const DashBoardPage());
      } else {
        print("error");
      }

      setState(() {
        _isLoading = false;
      });
    }

    void isTextFieldBlankValidation(String value) {
      if (usernameController.text.isEmpty) {
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
      appBar: backButtonAppbar(() {}, "Update Username", secondaryColor),
      backgroundColor: secondaryColor,
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
                    AppTextField(
                      label: "UserName",
                      hint: "username",
                      key: Key(1.toString()),
                      textController: usernameController,
                      onChanged: isTextFieldBlankValidation,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppButton(
                      text: _isLoading ? "Loading..." : "Update",
                      onPress: userUpdateOnClick,
                      buttonColour: primaryColor,
                      isDisabled: isButtonDisabled,
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
