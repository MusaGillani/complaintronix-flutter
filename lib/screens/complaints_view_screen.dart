import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';
import 'package:complaintronix/services/networking.dart' as api;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComplaintsViewScreen extends StatefulWidget {
  ComplaintsViewScreen({this.hostelNumber});

  final int hostelNumber; // hostel number of hostel head

  static const id = 'complaints_view_screen';

  @override
  _ComplaintsViewScreenState createState() => _ComplaintsViewScreenState();
}

class _ComplaintsViewScreenState extends State<ComplaintsViewScreen> {
  // List<Map<String, String>> _complaints;
  // [
  //   {'name': 'musa', 'room': '66', 'issue': 'Ehternet'},
  //   {'name': 'nabeel', 'room': '67', 'issue': 'Router'},
  //   {'name': 'zain', 'room': '65', 'issue': 'Cable'},
  // ];
  List<bool> _isChecked = [];

  Color _getColor(Set<MaterialState> state) {
    Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.focused,
      MaterialState.hovered,
      MaterialState.selected,
    };

    if (state.any(interactiveStates.contains)) {
      return Color(0xff1ed760);
    }
  }

  // Future<void> getComplaints() async {
  //   await api.getHostelComplaints(hostelNumber: widget.hostelNumber).then(
  //       (complaints) =>
  //           _isChecked = List<bool>.filled(complaints.length, false));
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: kAppbarTitle,
        ),
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(right: 30.0, left: 30.0, top: 20.0),
          padding: EdgeInsets.all(5.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HOSTEL HEAD',
                style: kLogoTextStyle.copyWith(color: Color(0xffd3d3d3)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('H-${widget.hostelNumber}', style: kLogoTextStyle),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      'Complaints',
                      style: kLogoTextStyle.copyWith(color: Color(0xffd3d3d3)),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                      onPressed: () => setState(() {}),
                      icon: Icon(
                        Icons.refresh_rounded,
                        size: 30.0,
                        color: Color(0xffd3d3d3),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status', style: kLogoTextStyle),
                  Text('Reg', style: kLogoTextStyle),
                  Text('room', style: kLogoTextStyle),
                  Text('issue', style: kLogoTextStyle),
                ],
              ),
              FutureBuilder(
                future:
                    api.getHostelComplaints(hostelNumber: widget.hostelNumber),
                builder: (context,
                    AsyncSnapshot<List<Map<String, String>>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        _isChecked.add(
                            snapshot.data[index]['isChecked'] == 'true'
                                ? true
                                : false);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      _getColor),
                              value: _isChecked[index],
                              onChanged: (newValue) async {
                                  await api.updateComplaint(reg: snapshot.data[index]['reg'],status: newValue ? 'completed' : 'pending');
                                  setState(() => _isChecked[index] = newValue);
                              }
                            ),
                            Text(
                              '${snapshot.data[index]['reg']}',
                              style: kLogoTextStyle.copyWith(
                                color: Color(0xffd3d3d3),
                              ),
                            ),
                            Text(
                              '${snapshot.data[index]['room']}',
                              style: kLogoTextStyle.copyWith(
                                color: Color(0xffd3d3d3),
                              ),
                            ),
                            Text(
                              '${snapshot.data[index]['issue']}',
                              style: kLogoTextStyle.copyWith(
                                color: Color(0xffd3d3d3),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

// Flexible(
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: complaints.length,
//                           itemBuilder: (context, index) => Checkbox(
//                             value: _isChecked[index],
//                             onChanged: (newValue) =>
//                                 setState(() => _isChecked[index] = newValue),
//                           ),
//                         ),
//                       ),

// ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: complaints.length,
//                         itemBuilder: (context, index) => Text(
//                           '${complaints[index]['name']}',
//                           style: kLogoTextStyle.copyWith(
//                             color: Color(0xffd3d3d3),
//                           ),
//                         ),
//                       ),
