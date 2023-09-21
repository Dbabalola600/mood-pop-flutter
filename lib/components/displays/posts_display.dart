import 'package:flutter/material.dart';

import '../../utils/colours.dart';


class FeedProps {
  final String? image;
  final String name;
  final String date;
  final String content;

  FeedProps({
    this.image,
    required this.name,
    required this.date,
    required this.content,
  });
}class PostsDisplay extends StatefulWidget {
  final FeedProps props;

  PostsDisplay({required this.props});

  @override
  _PostsDisplayState createState() => _PostsDisplayState();
}

class _PostsDisplayState extends State<PostsDisplay> {
  
 

  @override
 Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10), // Add horizontal padding
    child: Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
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
                // if (props.image == null)
                Container(
                  child: Icon(
                    Icons.person_outline,
                    size: 50,
                    color: Color(0xFF0413BB),
                  ),
                ),
                // else
                //   Image.network(
                //     props.image!,
                //     width: 50,
                //     height: 50,
                //     fit: BoxFit.fill,
                //   ),
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
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight, // Align the "Delete" icon to the top right
                    child: GestureDetector(
                      onTap: () {
                        // Handle the press event
                      },
                      child: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
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
