import 'package:flutter/material.dart';

const kLogoTextStyle = TextStyle(
  fontFamily: 'Chosence Bold',
  fontSize: 25.0,
  color: Color(0xff1ed760),
);

const kInputFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black,
  hintText: 'Enter',
  hintStyle: TextStyle(
    color: Color(0xffd3d3d3),
    fontStyle: FontStyle.italic,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

var kAppbarTitle = Container(
  padding: EdgeInsets.only(bottom: 1.0),
  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xffd3d3d3),
        width: 5.0,
      ),
    ),
  ),
  child: Text(
    'COMPLAINTRONIX',
    style: kLogoTextStyle,
  ),
);

enum GroupValue { ETHERNET, ROUTER, CABLE_BROKEN, CABLE_SHORT }

const kMessageFiekdDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: Color(0xff1ed760),
      width: 2.0,
    ),
  ),
);
