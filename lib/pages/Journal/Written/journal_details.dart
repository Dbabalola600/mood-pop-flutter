import 'package:flutter/material.dart';
import 'package:get/get.dart';



import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/displays/app_decision_alert_dialogue.dart';
import '../../../components/displays/back_appbar.dart';
import '../../../components/displays/load_screen.dart';
import '../../../requests/auth_request.dart';
import '../../../utils/colours.dart';
import '../journal_page.dart';


class JournalDetailsPage extends StatefulWidget {
  final String nId;
  const JournalDetailsPage(this.nId, {Key? key}) : super(key: key);
  @override
  State<JournalDetailsPage> createState() => _JournalDetailsPageState();
}

class Journal {
  final dynamic id;
  String title;
  dynamic content;
  dynamic date;

  Journal(
      {required this.id,
      required this.date,
      required this.content,
      required this.title});
}

class _JournalDetailsPageState extends State<JournalDetailsPage> {
  bool _isLoading = false;
  bool showError = false;
  Journal? journInfo =
      Journal(id: "id", date: "date", content: "content", title: "title");

  @override
  void initState() {
    super.initState();
    showInfo();
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the user ID from SharedPreferences
    String? userId = prefs.getString("userId");
    final response = await getNote(userId: userId, noteId: widget.nId);

    setState(() {
      journInfo?.content = response["content"];
      journInfo?.title = response["title"];
      journInfo?.date = response["Date"];
      _isLoading = false;
    });

    setState(() {
      _isLoading = false;
    });
  }

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppADecisionlertDialogue(
          onTap: () => {userDelete ()},
          title: 'Are you sure you wish to delete',
          content: '',
          contentColor: primaryColor,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  showError = false; // Set showError to false when closing
                });
              },
              child: const Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  showError = false; // Set showError to false when closing
                });
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void userDelete() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get the user ID from SharedPreferences
    String? userId = prefs.getString("userId");
    var response = await deleteNote(userId: userId, noteId: widget.nId);
    if (response["status"] == 200) {
      Get.to( const JournalPage());
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
            backButtonAppbar(() {}, journInfo?.title ?? " ", secondaryColor),
        backgroundColor: secondaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _isLoading
              ? LoadingScreen()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showError = true;
                                  });
                                  showLoginErrorDialog(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Adjust alignment as needed
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: whiteColor,
                                      ),
                                      Text(
                                        "Delete", // Add your additional text here
                                        textAlign: TextAlign.right,
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(journInfo?.content ?? " "),
                          ],
                        )
                      ]),
                ),
        )),
      ),
    );
  }
}
