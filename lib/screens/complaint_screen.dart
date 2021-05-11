import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';
import 'package:complaintronix/components/green_round_button.dart';

class ComplaintScreen extends StatefulWidget {
  ComplaintScreen({this.hostelNumber});

  static const id = 'complaint_screen';
  final int hostelNumber;

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {

  GroupValue _groupValue = GroupValue.ETHERNET;

  @override
  Widget build(BuildContext context) {
    String name;
    String roomNumber;
    String phoneNumber;
    GroupValue groupValue = GroupValue.ETHERNET;
    // final Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    print(widget.hostelNumber);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: kAppbarTitle,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(right: 30.0, left: 30.0, top: 20.0),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: (newValue) {
                name = newValue;
              },
              style: TextStyle(color: Color(0xffd3d3d3)),
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              onChanged: (newValue) {
                roomNumber = newValue;
              },
              style: TextStyle(color: Color(0xffd3d3d3)),
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'Room number',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              onChanged: (newValue) {
                phoneNumber = newValue;
              },
              style: TextStyle(color: Color(0xffd3d3d3)),
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'phone number',
              ),
            ),
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
            GreenRoundButton(buttonText: 'SUBMIT',onTap: _showDialogBox),
          ],
        ),
      ),
    );
  }

  Widget _radioButton({String title, GroupValue value,Function onChanged}){
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

  Future<void> _showDialogBox(){
    return showDialog<void>(context: context, builder: (context){
      return AlertDialog(
        title: Text('Complaint Registered'),
        backgroundColor: Colors.black12,
        elevation: 10.0,
      );
    });
  }
}

// class RadioButton extends StatefulWidget {
//   RadioButton({this.title, this.value});

//   String title;
//   GroupValue value;
//   GroupValue groupValue;

//   @override
//   _RadioButtonState createState() => _RadioButtonState();
// }

// class _RadioButtonState extends State<RadioButton> {
//   @override
//   Widget build(BuildContext context) {
//     return RadioListTile(
//       title: Text(
//         widget.title,
//         style: kLogoTextStyle.copyWith(
//           color: Color(0xffd3d3d3),
//         ),
//       ),
//       value: widget.value,
//       groupValue: widget.groupValue,
//       onChanged: (newValue) {
//         setState(() {
//           widget.groupValue = newValue;
//         });
//       },
//     );
//   }
// }