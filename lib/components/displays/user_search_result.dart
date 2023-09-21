import 'package:flutter/material.dart';
import 'package:mood_pop/utils/colours.dart';

class UserSearchResult extends StatelessWidget {
  final dynamic image;
  final dynamic name;
  final Function? clicky;
  final String cilckyText;

  const UserSearchResult({super.key, 
    required this.image,
    required this.name,
    this.clicky,
    required this.cilckyText,
  });

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 48.0,
            width: 48.0,
            child: image == null
                ? const Icon(
                    Icons.person_outline,
                    size: 37.0,
                    color: Color(0xFF0413BB),
                  )
                : Image(
                    image:
                        image), // You might need to adjust this part based on how you're handling images.
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: Text(
                name.toString(),
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
                  clicky!();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    cilckyText,
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
