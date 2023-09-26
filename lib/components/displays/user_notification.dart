import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserNotificationProps {
  dynamic image;
  final dynamic name;
  final Function? Acceptclicky;
  final Function? Declineclicky;

  UserNotificationProps({
    this.image,
    required this.name,
    this.Acceptclicky,
    this.Declineclicky,
  });
}

class UserNotification extends StatefulWidget {
  final UserNotificationProps props;

  UserNotification({required this.props});

  @override
  _UserNotificationState createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  @override
  Widget build(BuildContext context) {
    String base64ImageWithPrefix = widget.props.image;

    // Remove the prefix and decode the base64 string into bytes
    String base64Image = base64ImageWithPrefix.split(',').last;
    Uint8List uint8List = base64.decode(base64Image);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 70.0,
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: (uint8List.isNotEmpty)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Image.memory(
                        uint8List!,
                        fit: BoxFit
                            .cover, // Use BoxFit.cover to fill the container
                      ),
                    ),
                  )
                : const Icon(
                    Icons.person_outline,
                    size: 50,
                    color: Color(0xFF0413BB),
                  ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                widget.props.name.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  widget.props.Acceptclicky!();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '✓',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  widget.props.Declineclicky!();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[500],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'X',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
