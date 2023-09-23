import 'package:flutter/material.dart';
import 'package:mood_pop/components/inputs/large_app_textfield.dart';

import '../../components/displays/app_button.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../utils/colours.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({Key? key}) : super(key: key);

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final contactSupportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      textController: contactSupportController,
                      // onChanged: isTextFieldBlankValidation,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    LargeAppTextField(
                        label: "Content",
                        hint: "Let Us know in detail what you need",
                        textController: contactSupportController),
                    const SizedBox(
                      height: 30,
                    ),
                    AppButton(
                      text: "Update",
                      onPress: () {},
                      buttonColour: primaryColor,
                      // onPress: () => Get.to(const DashBoardPage()),
                      // isDisabled: isButtonDisabled,
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
