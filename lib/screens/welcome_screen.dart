import 'package:complaintronix/screens/complaints_view_screen.dart';
import 'package:complaintronix/services/auth.dart';
import 'package:complaintronix/utilities/constants.dart';
import 'package:complaintronix/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:complaintronix/components/green_round_button.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:complaintronix/components/alert_box.dart' as alert;
import 'hostel_screen.dart';
import 'package:complaintronix/services/networking.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AuthService _auth = AuthService();
  final GoogleAuthService _googleAuth = GoogleAuthService();
  String email;
  String password;
  bool _loading = false;
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
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
                    controller: controllerEmail,
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
                    controller: controllerPassword,
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
                    onTap: () async {
                      if (controllerEmail.text == '' ||
                          controllerPassword.text == '')
                        alert.showDialogBox(
                            context, 'Both fields are required !');
                      else {
                        setState(() => _loading = true);
                        dynamic result = await _auth.signInWithEmail(
                            email: email, password: password);
                        setState(() => _loading = false);
                        print(result);
                        if (result != null) {
                          controllerEmail.clear();
                          controllerPassword.clear();
                          dynamic hostelNumber = await Networking()
                              .checkhostelHeads(email: result.email);
                          if (hostelNumber == 0)
                            Navigator.pushNamed(context, HostelScreen.id);
                          else
                            Navigator.pushNamed(
                                context, ComplaintsViewScreen.id,
                                arguments: hostelNumber);
                        } else {
                          alert.showDialogBox(context,
                              'Could not sign in with these credentials');
                        }
                      }
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
                      GestureDetector(
                        child: CircleAvatar(
                          child: Icon(
                            FontAwesomeIcons.google,
                            color: Color(0xff1ed760),
                            size: 40.0,
                          ),
                        ),
                        onTap: () async {
                          setState(() => _loading = true);
                          dynamic result = await _googleAuth.signInGoogle();
                          setState(() => _loading = false);

                          if (result != null) {
                            Navigator.pushNamed(context, HostelScreen.id);
                          } else {
                            alert.showDialogBox(context,
                                'Could not sign in with these credentials');
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GreenRoundButton(
                    onTap: () async {
                      if (controllerEmail.text == '' ||
                          controllerPassword.text == '')
                        alert.showDialogBox(
                            context, 'Both fields are required !');
                      else {
                        setState(() => _loading = true);
                        dynamic result = await _auth.registerWithEmail(
                            email: email, password: password);
                        if (result != null) {
                          setState(() => _loading = false);
                          controllerEmail.clear();
                          controllerPassword.clear();
                          Navigator.pushNamed(context, HostelScreen.id);
                        } else {
                          setState(() => _loading = false);
                          alert.showDialogBox(context, 'User already exists !');
                        }
                      }
                    },
                    buttonText: 'REGISTER',
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
