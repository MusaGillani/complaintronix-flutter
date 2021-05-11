import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';

class RegisterScreen extends StatelessWidget {
  static const id = 'register_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: kAppbarTitle,
      ),
      body: Container(
        margin: EdgeInsets.all(50.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff1ed760),
              width: 5,
            ),
            borderRadius: BorderRadius.circular(50)),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
