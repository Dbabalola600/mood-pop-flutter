import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../utils/colours.dart';

class FeedProps {
  final String image;
  final String name;
  final String date;
  final String content;

  FeedProps({
    required this.image,
    required this.name,
    required this.date,
    required this.content,
  });
}


class FeedDisplay extends StatefulWidget {
  final FeedProps props;

  FeedDisplay({required this.props});

  @override
  _FeedDisplayState createState() => _FeedDisplayState();
}

class  _FeedDisplayState extends State<FeedDisplay> {




  @override
  Widget build(BuildContext context) {
    String base64ImageWithPrefix = widget.props.image;

    // Remove the prefix and decode the base64 string into bytes
    String base64Image = base64ImageWithPrefix.split(',').last;
    Uint8List uint8List = base64.decode(base64Image);
    Image image = Image.memory(
      uint8List,
      fit: BoxFit.contain, // You can set the fit as needed
    );

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 5), // Add horizontal padding
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    // bottomLeft: Radius.circular(10),
                    // bottomRight: Radius.circular(10),
                    // topLeft: Radius.circular(5),
                    ),
              ),
              margin: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  Container(
                    child: (uint8List != null && uint8List.isNotEmpty)
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
                        : Icon(
                            Icons.person_outline,
                            size: 50,
                            color: Color(0xFF0413BB),
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.props.name),
                        Text(widget.props.date),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6B52AE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    widget.props.content,
                    style: const TextStyle(
                      color: blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
