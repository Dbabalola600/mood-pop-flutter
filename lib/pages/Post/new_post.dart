import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../components/displays/app_button.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../components/inputs/large_app_textfield.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';


class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);
  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  // page state
  bool isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    void isTextFieldBlankValidation() {
      if (titleTextController.text.isEmpty ||
          contentTextController.text.isEmpty) {
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
        appBar: backButtonAppbar(() {}, "New Post", secondaryColor),
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
                        height: 30,
                      ),
                      AppTextField(
                        label: "Title",
                        hint: "title",
                        // key: Key(1.toString()),
                        textController: titleTextController,
                        onChanged: (text) {
                          isTextFieldBlankValidation();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      LargeAppTextField(
                        hint: "What's up?",
                        label: "Content",
                        textController: contentTextController,
                        onChanged: (text) {
                          isTextFieldBlankValidation();
                        },

                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppButton(
                         buttonColour: primaryColor,
                        text: "Create Post",
                        onPress: () => Get.to(const DashBoardPage()),
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
          ),
        ),
      ),
    );
  }
}
