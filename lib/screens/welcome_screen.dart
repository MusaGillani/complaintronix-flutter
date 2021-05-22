import 'package:complaintronix/screens/complaints_view_screen.dart';
import 'package:complaintronix/utilities/constants.dart';
import 'package:complaintronix/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:complaintronix/components/green_round_button.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'hostel_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // stop widgets from resizing when keyboard appears
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: kAppbarTitle,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
            margin: EdgeInsets.all(50.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff1ed760),
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(50)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'SIGN IN',
                  style: kLogoTextStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (newValue) {
                    email = newValue;
                  },
                  style: TextStyle(
                    color: Color(0xffd3d3d3),
                  ),
                  decoration:
                      kInputFieldDecoration.copyWith(hintText: 'Enter email'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (newValue) {
                    password = newValue;
                  },
                  style: TextStyle(
                    color: Color(0xffd3d3d3),
                  ),
                  decoration: kInputFieldDecoration.copyWith(
                      hintText: 'Enter password'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'LOG IN',
                //     style: kLogoTextStyle.copyWith(color: Colors.white),
                //   ),
                // ),
                GreenRoundButton(
                  onTap: (){
                    Navigator.pushNamed(context, ComplaintsView.id);
                  },
                  buttonText: 'LOG IN',
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'OR LOG IN WITH',
                  style: kLogoTextStyle.copyWith(color: Color(0xffd3d3d3)),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xff1ed760),
                        size: 40.0,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xff1ed760),
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                GreenRoundButton(
                  onTap: () {
                    Navigator.pushNamed(context, HostelScreen.id);
                  },
                  buttonText: 'REGISTER',
                ),
              ],
            )),
      ),
    );
  }
}
