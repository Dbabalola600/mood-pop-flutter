import 'package:flutter/material.dart';

import '../../utils/colours.dart';

class AppAlertDialogue extends StatelessWidget {
  const AppAlertDialogue({
    Key? key,
    this.content = "",
    this.title = "",
    this.contentColor = Colors.black,
    required this.actions,
  }) : super(key: key);

  final String content;
  final String title;
  final Color contentColor;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
          content,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(primaryColor)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
