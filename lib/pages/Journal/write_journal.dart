import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/app_alert_dialogue.dart';
import '../../components/displays/app_button.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../components/inputs/large_app_textfield.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import 'journal_page.dart';

class WriteJournalPage extends StatefulWidget {
  const WriteJournalPage({Key? key}) : super(key: key);
  @override
  State<WriteJournalPage> createState() => _WriteJournalPageState();
}

class _WriteJournalPageState extends State<WriteJournalPage> {
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  // page state
  bool isButtonDisabled = true;
  bool _isLoading = false;
  String? userId = " ";
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
  void initState() {
    super.initState();
    loadSharedPreferences();
    // Call showInfo when the widget is inserted into the tree.
  }

  Future<void> loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    void userButtonClick() async {
      setState(() {
        _isLoading = true;
      });
      var response = await createJournal(
          userId: userId,
          title: titleTextController.text,
          content: contentTextController.text);

      if (response["status"] == 200) {
        Get.to(const JournalPage());
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
        appBar: backButtonAppbar(() {}, "Write Journal", secondaryColor),
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
                        text: _isLoading ? "Loading..." : "Create Note",
                        onPress: userButtonClick,
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
          ),
        ),
      ),
    );
  }
}
