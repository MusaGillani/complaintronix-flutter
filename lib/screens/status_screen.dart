import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';
import 'package:complaintronix/services/networking.dart' as api;
import '../components/alert_box.dart' as alert;
import 'chat_screen.dart';

class StatusScreen extends StatefulWidget {
  StatusScreen({this.args});

  static const String id = 'status_screen';
  final Map args;

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // leading: Builder(
        //   builder: (context) {
        //     return BackButton(
        //       onPressed: () async {
        //         // if (_auth.currentUser() != null) {
        //         //   await _auth.signOut();
        //         //   Navigator.of(context).pop(context);
        //         // }
        //         // if (_googleAuth.currentUser() != null) {
        //         //   await _googleAuth.signOut();
        //         //   // Navigator.of(context).pop(context);
        //         // }
        //       },
        //     );
        //   },
        // ),
        centerTitle: true,
        title: kAppbarTitle,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, ChatScreen.id,
                  arguments: widget.args['email']);
            },
            child: Text(
              'Chat',
              style: kLogoTextStyle.copyWith(color: Color(0xffd3d3d3)),
            ),
            style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 20.0)),
          ),
        ],
      ),
      // body: FutureBuilder(
      //   future: api.getComplaintStatus(email: widget.email),
      //   builder: (context, AsyncSnapshot<String> snapshot) => Center(
      //     child: Text(
      //       'Current status: ${snapshot.data}',
      //       style: kLogoTextStyle.copyWith(
      //         color: Color(0xffd3d3d3),
      //       ),
      //     ),
      //   ),
      // ),
      body: Center(
        child: Text(
          'Current status: ${widget.args['status']}',
          style: kLogoTextStyle.copyWith(
            color: Color(0xffd3d3d3),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // api call to delete
          int statusCode = await api.deleteComplaint(reg: widget.args['reg']);
          if (statusCode == 200)
            alert.showDialogBox(context, 'Thank you for your feedback !');
          else
            alert.showDialogBox(
                context, 'Could not mark the complaint complete! ');
        },
        label: Text('Resolved',
            style: kLogoTextStyle.copyWith(color: Color(0xff000000))),
        icon: Icon(
          Icons.done,
          size: 30.0,
        ),
        backgroundColor: Color(0xff1ed760),
      ),
    );
  }
}
