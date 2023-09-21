import 'package:flutter/material.dart';

import '../../../utils/colours.dart';




class ovalButton extends StatelessWidget {
  const ovalButton(
      {Key? key,
      required this.name,
      required this.onTap,
      required this.icon,
      required this.svgUrlString})
      : super(key: key);

  final void Function() onTap;
  final String name;
  final dynamic svgUrlString;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: whiteColor,
      onTap: onTap,
    
      child: Container(

        height: 80,
        width: 100,
        decoration: BoxDecoration(
          color:disabledColor ,
          borderRadius: BorderRadius.circular(30),
          
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              icon,
              // SvgPicture.asset(
              //   svgUrlString,
              //   height: 20,
              // ),
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
