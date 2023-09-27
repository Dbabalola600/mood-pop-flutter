import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/app_button.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../components/inputs/large_app_textfield.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({Key? key}) : super(key: key);

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  bool isButtonDisabled = true;
  bool _isLoading = false;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    void userOnClick() async {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var response = await contactSupport(
          details: detailsController.text,
          email: prefs.getString("email"),
          title: titleController.text);
      print(response.toString());
      if (response["status"].toString() == "200") {
        Get.to(const DashBoardPage());
      } else {
        setState(() {
          showError = true;
        });
      }

      setState(() {
        _isLoading = false;
      });
    }

    void isTextFieldBlankValidation(String value) {
      if (titleController.text.isEmpty || detailsController.text.isEmpty) {
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
      appBar: backButtonAppbar(() {}, "Update ContactSupport", secondaryColor),
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
                      height: 20,
                    ),
                    AppTextField(
                      label: "Title",
                      hint: "Give your message a title",
                      key: Key(1.toString()),
                      textController: titleController,
                      onChanged: isTextFieldBlankValidation,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    LargeAppTextField(
                        label: "Content",
                        hint: "Let Us know in detail what you need",
                        textController: detailsController,
                        onChanged: isTextFieldBlankValidation,
                        ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppButton(
                       text: _isLoading ? "Loading..." : "Send",
                    

                      buttonColour: primaryColor,
                      onPress: userOnClick,
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
