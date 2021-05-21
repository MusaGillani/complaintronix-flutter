import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';

class ComplaintsView extends StatelessWidget {

  static const id = 'complaints_view_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: kAppbarTitle,
      ),
      backgroundColor: Colors.black,
      body: Container(),
    );
  }
}