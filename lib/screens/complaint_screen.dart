import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';
import 'package:complaintronix/components/green_round_button.dart';
import 'package:complaintronix/components/alert_box.dart' as alert;
import 'package:complaintronix/services/networking.dart' as api;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ComplaintScreen extends StatefulWidget {
  ComplaintScreen({this.email});

  static const id = 'complaint_screen';
  final String email;

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final controllerRoom = TextEditingController();

  String name;
  String reg;
  String desc;
  // String email;
  GroupValue _groupValue = GroupValue.ETHERNET;
  bool _loading = false;

  String _getComplaintType(GroupValue groupValue) {
    if (groupValue == GroupValue.ETHERNET) return 'Ethrnt';
    if (groupValue == GroupValue.ROUTER) return 'Router';
    if (groupValue == GroupValue.CABLE_BROKEN) return 'BCable';
    if (groupValue == GroupValue.CABLE_SHORT) return 'SCable';
  }

  @override
  void initState() {
    super.initState();
    // _currentUser = _auth.currentUser() ?? _googleAuth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    // final Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;

    // print(widget.hostelNumber);
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        appBar: AppBar(
          // leading: Builder(
          //   builder: (context) {
          //     return BackButton(
          //       onPressed: () async {
          //         // if (_auth.currentUser() != null) {
          //         //   await _auth.signOut();
          //         //   Navigator.pop(context);
          //         // }
          //         // if (_googleAuth.currentUser() != null) {
          //         //   await _googleAuth.signOut();
          //         //   Navigator.pop(context);
          //         // }
          //       },
          //     );
          //   },
          // ),
          centerTitle: true,
          title: kAppbarTitle,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(right: 30.0, left: 30.0, top: 20.0),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Select your ISSUE',
                  style: kLogoTextStyle.copyWith(
                    color: Color(0xffd3d3d3),
                    fontSize: 40.0,
                  ),
                ),
              ),
              TextField(
                controller: controllerRoom,
                keyboardType: TextInputType.text,
                onChanged: (newValue) {
                  desc = newValue;
                },
                style: TextStyle(color: Color(0xffd3d3d3)),
                decoration: kInputFieldDecoration.copyWith(
                  hintText: 'Description',
                ),
                maxLines: 5,
                // minLines: 3,
              ),
              SizedBox(
                height: 20.0,
              ),
              _radioButton(
                title: 'ETHERNET ISSUE',
                value: GroupValue.ETHERNET,
                onChanged: (newValue) => setState(() => _groupValue = newValue),
              ),
              SizedBox(
                height: 10.0,
              ),
              _radioButton(
                title: 'ROUTER ISSUE',
                value: GroupValue.ROUTER,
                onChanged: (newValue) => setState(() => _groupValue = newValue),
              ),
              SizedBox(
                height: 10.0,
              ),
              _radioButton(
                title: 'CABLE BROKEN',
                value: GroupValue.CABLE_BROKEN,
                onChanged: (newValue) => setState(() => _groupValue = newValue),
              ),
              SizedBox(
                height: 10.0,
              ),
              _radioButton(
                title: 'CABLE SHORT',
                value: GroupValue.CABLE_SHORT,
                onChanged: (newValue) => setState(() => _groupValue = newValue),
              ),
              SizedBox(
                height: 25.0,
              ),
              // SizedBox(
              //   height: 10,
              // ),

              GreenRoundButton(
                buttonText: 'SUBMIT',
                onTap: () async {
                  if (controllerRoom.text == '')
                    alert.showDialogBox(context, 'Description is required!');
                  else {
                    controllerRoom.clear();
                    setState(() => _loading = true);
                    int status = await api.registerComplaint(
                      email: widget.email,
                      desc: desc,
                      type: _getComplaintType(_groupValue),
                    );
                    setState(() => _loading = false);
                    if (status == 200)
                      alert.showDialogBox(context, 'Complaint Registered');
                    else if (status == 409)
                      alert.showDialogBox(context,
                          'Complaint Already Registered \n Against This Reg!!');
                    else {
                      alert.showDialogBox(
                          context, 'Could not register Complaint');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioButton({String title, GroupValue value, Function onChanged}) {
    return RadioListTile(
      activeColor: Color(0xff1ed760),
      title: Text(
        '\t\t$title',
        textAlign: TextAlign.justify,
        style: kLogoTextStyle.copyWith(
          color: Color(0xffd3d3d3),
          fontSize: 30.0,
        ),
      ),
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
    );
  }
}
