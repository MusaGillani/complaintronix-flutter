import 'package:complaintronix/utilities/constants.dart';
import 'package:flutter/material.dart';

class GreenRoundButton extends StatelessWidget {

  GreenRoundButton({this.buttonText,this.onTap});

  final Function onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff1ed760),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          child: Text(
            buttonText,
            style: kLogoTextStyle.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
