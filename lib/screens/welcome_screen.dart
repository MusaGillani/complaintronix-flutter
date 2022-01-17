import 'package:flutter/material.dart';
import 'package:complaintronix/services/auth.dart';
import 'package:complaintronix/utilities/constants.dart';
import 'package:complaintronix/components/green_round_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:complaintronix/components/alert_box.dart' as alert;
import 'package:complaintronix/screens/complaints_view_screen.dart';
import 'package:complaintronix/screens/status_screen.dart';
import 'hostel_screen.dart';
import 'package:complaintronix/services/networking.dart' as api;
import 'package:complaintronix/screens/complaint_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // final AuthService _auth = AuthService();
  String email, name;
  String password;
  String reg, hostel, room;
  bool _loading = false;
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerReg = TextEditingController();
  final controllerRoom = TextEditingController();
  final controllerName = TextEditingController();
  final controllerHostel = TextEditingController();

  bool _head = false;
  bool _login = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // stop widgets from resizing when keyboard appears
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: kAppbarTitle,
          actions: [
            TextButton(
              child: Text(
                _login ? 'Register' : 'Login',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  _login = !_login;
                });
              },
            )
          ],
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
                  keyboardType:
                      _head ? TextInputType.number : TextInputType.emailAddress,
                  onChanged: (newValue) {
                    if (!_head)
                      email = newValue;
                    else
                      reg = newValue;
                  },
                  style: TextStyle(
                    color: Color(0xffd3d3d3),
                  ),
                  decoration: kInputFieldDecoration.copyWith(
                      hintText: _head ? 'Enter Reg' : 'Enter email'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType:
                      _head ? TextInputType.number : TextInputType.text,
                  controller: controllerPassword,
                  obscureText: !_head,
                  onChanged: (newValue) {
                    if (!_head)
                      password = newValue;
                    else
                      hostel = newValue;
                  },
                  style: TextStyle(
                    color: Color(0xffd3d3d3),
                  ),
                  decoration: kInputFieldDecoration.copyWith(
                      hintText: _head ? 'Enter hostel' : 'Enter password'),
                ),
                SizedBox(height: 20.0),

                if (!_login) ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controllerName,
                          onChanged: (newValue) {
                            name = newValue;
                          },
                          style: TextStyle(color: Color(0xffd3d3d3)),
                          decoration: kInputFieldDecoration.copyWith(
                            hintText: 'name',
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: controllerReg,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            reg = newValue;
                          },
                          style: TextStyle(color: Color(0xffd3d3d3)),
                          decoration: kInputFieldDecoration.copyWith(
                            hintText: 'reg',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controllerHostel,
                          onChanged: (newValue) {
                            hostel = newValue;
                          },
                          style: TextStyle(color: Color(0xffd3d3d3)),
                          decoration: kInputFieldDecoration.copyWith(
                            hintText: 'hostel',
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: controllerRoom,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            room = newValue;
                          },
                          style: TextStyle(color: Color(0xffd3d3d3)),
                          decoration: kInputFieldDecoration.copyWith(
                            hintText: 'room',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                if (_login) ...[
                  GreenRoundButton(
                    onTap: () async {
                      if (controllerEmail.text == '' ||
                          controllerPassword.text == '')
                        alert.showDialogBox(
                            context, 'Both fields are required !');
                      else {
                        setState(() => _loading = true);
                        if (!_head) {
                          dynamic result = await api.signInWithEmail(
                              email: email, password: password);
                          setState(() => _loading = false);

                          print(result);
                          if (result != "empty") {
                            controllerEmail.clear();
                            controllerPassword.clear();
                            dynamic complaint =
                                await api.getComplaintStatus(email: email);
                            if (complaint != 'empty') {
                              Navigator.pushNamed(context, StatusScreen.id,
                                  arguments: {
                                    'reg': complaint[0]['complaintee_reg'],
                                    'status': complaint[0]['complaint_status'],
                                    'email': email,
                                  });
                            } else
                              Navigator.pushNamed(context, ComplaintScreen.id,
                                  arguments: email);
                          } else {
                            alert.showDialogBox(context,
                                'Could not sign in with these credentials');
                          }
                        } else {
                          dynamic result = await api.checkhostelHeads(
                              reg: reg, hostel: hostel);
                          setState(() => _loading = false);
                          if (result == 'empty') {
                            alert.showDialogBox(context,
                                'Could not sign in with these credentials');
                          } else {
                            controllerEmail.clear();
                            controllerPassword.clear();
                            Navigator.pushNamed(
                                context, ComplaintsViewScreen.id,
                                arguments: {
                                  'hostelNumber': int.parse(hostel),
                                  'email': email,
                                });
                          }
                        }
                        /*
                      if (hostelNumber == 0) {
                        dynamic complaint =
                            await api.getComplaintStatus(email: result.email);
                        if (complaint != 'empty') {
                          Navigator.pushNamed(context, StatusScreen.id,
                              arguments: {
                                'reg': complaint[0]['reg_no'],
                                'status': complaint[0]['status']
                              });
                        } else
                          Navigator.pushNamed(context, HostelScreen.id);
                      } else
                        Navigator.pushNamed(context, ComplaintsViewScreen.id,
                            arguments: hostelNumber);
                            */
                      }
                    },
                    buttonText: 'LOG IN',
                  ),
                  SwitchListTile(
                    title: Text('Head Login?'),
                    value: _head,
                    onChanged: (_) {
                      setState(() {
                        _head = !_head;
                      });
                    },
                  ),
                ],
                if (!_login) ...[
                  GreenRoundButton(
                    onTap: () async {
                      if (controllerEmail.text == '' ||
                          controllerPassword.text == '' ||
                          controllerHostel.text == '' ||
                          controllerReg.text == '' ||
                          controllerRoom.text == '' ||
                          controllerName.text == '')
                        alert.showDialogBox(
                            context, 'All fields are required !');
                      else {
                        setState(() => _loading = true);
                        dynamic result = await api.registerWithEmail(
                          email: email,
                          password: password,
                          name: name,
                          reg: reg,
                          hostel: hostel,
                          room: room,
                        );
                        if (result == 'added') {
                          setState(() => _loading = false);
                          controllerEmail.clear();
                          controllerPassword.clear();
                          controllerName.clear();
                          controllerReg.clear();
                          controllerRoom.clear();
                          controllerHostel.clear();
                          Navigator.pushNamed(context, ComplaintScreen.id,
                              arguments: email);
                        } else if (result == 'exists') {
                          setState(() => _loading = false);
                          alert.showDialogBox(context, 'User already exists !');
                        }
                      }
                    },
                    buttonText: 'REGISTER',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
