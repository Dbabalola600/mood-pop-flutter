import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/app_alert_dialogue.dart';
import '../../components/displays/app_button.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';

class UpdateEmailPage extends StatefulWidget {
  const UpdateEmailPage({Key? key}) : super(key: key);

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  final emailController = TextEditingController();
  bool isButtonDisabled = true;
  bool _isLoading = false;
   bool showError = false;

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialogue(
          title: 'Unknown Error',
          content: 'An error occured try again later',
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
  @override
  Widget build(BuildContext context) {
    void userUpdateOnClick() async {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var response = await updateEmail(
          email: emailController.text, id: prefs.getString("userId"));
      // print(response.toString());
      if (response["status"].toString() == "200") {
        prefs.setString("email", emailController.text);

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

    return Scaffold(
      appBar: backButtonAppbar(() {}, "Update Email", secondaryColor),
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
                      label: "Email",
                      hint: "Email",
                      textInputType: TextInputType.emailAddress,
                      key: Key(1.toString()),
                      textController: emailController,
                      onChanged: isTextFieldBlankValidation,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppButton(
                      text: _isLoading ? "Loading..." : "Update",
                      buttonColour: primaryColor,
                      onPress: userUpdateOnClick,
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
