import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/back_appbar.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';

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

          child: Padding(
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
                          onTap: () {},
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
