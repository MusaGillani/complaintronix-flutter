import 'package:flutter/material.dart';

Future<void> showDialogBox(BuildContext context,String text){
    return showDialog<void>(context: context, builder: (context){
      return AlertDialog(
        title: Text(text),
        backgroundColor: Colors.black12,
        elevation: 10.0,
      );
    });
  }