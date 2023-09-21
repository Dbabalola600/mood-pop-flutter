import 'package:flutter/material.dart';

class UserNotification extends StatelessWidget {
  final dynamic image;
  final dynamic name;
  final Function? Acceptclicky;
  final Function? Declineclicky;

  UserNotification({
    required this.image,
    required this.name,
    this.Acceptclicky,
    this.Declineclicky,
  });

  @override
  Widget build(BuildContext context) {
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
            height: 48.0,
            width: 48.0,
            child: image == null
                ? Icon(
                    Icons.person_outline,
                    size: 37.0,
                    color: Color(0xFF0413BB),
                  )
                : Image(image: image), // You might need to adjust this part based on how you're handling images.
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                name.toString(),
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
                 
                    Acceptclicky!();

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

                    Declineclicky!();

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
