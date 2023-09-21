import 'package:flutter/material.dart';
import '../../utils/colours.dart';

class AppButton extends StatefulWidget {
  AppButton(
      {Key? key,
      required this.text,
      required this.onPress,
      this.isDisabled = false,
      required this.buttonColour,
      //  required this.textColour ,
      this.iconic})
      : super(key: key);

  final String text;
  IconData? iconic;
  final dynamic onPress;
  final bool isDisabled;
  final Color buttonColour;
//  final Color textColour ;
  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: widget.isDisabled ? null : widget.onPress,
          style: ButtonStyle(
            backgroundColor: widget.isDisabled
                ? MaterialStateProperty.all<Color>(disabledColor)
                : MaterialStateProperty.all(widget.buttonColour),
            elevation: MaterialStateProperty.all(1),
          ),
          child: Row(
            children: [
              Icon(widget.iconic),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void naviGate() {}
}
