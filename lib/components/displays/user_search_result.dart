import 'package:flutter/material.dart';


import 'dart:convert';
import 'dart:typed_data';
import 'package:mood_pop/utils/colours.dart';

class UserSearchProps {
   dynamic image;
   dynamic name;
  final Function clicky;
  final String cilckyText;

  UserSearchProps({
     this.image,
    required this.name,
    required this.clicky,
    required this.cilckyText,
  });
}

class UserSearchResult extends StatefulWidget {
  final UserSearchProps props;

  UserSearchResult({required this.props});

  @override
  _UserSearchResultState createState() => _UserSearchResultState();
}

class _UserSearchResultState extends State<UserSearchResult> {
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
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: ( uint8List.isNotEmpty)
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
              margin: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.props.name,
                style: const TextStyle(
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
                  widget.props.clicky!();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.props.cilckyText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
