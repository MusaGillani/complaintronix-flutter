import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';

class ComplaintsViewScreen extends StatefulWidget {

  ComplaintsViewScreen({this.hostelNumber});

  final int hostelNumber; // hostel number of hostel head

  static const id = 'complaints_view_screen';

  @override
  _ComplaintsViewScreenState createState() => _ComplaintsViewScreenState();
}

class _ComplaintsViewScreenState extends State<ComplaintsViewScreen> {
  List<Map> complaints = [
    {'name': 'musa', 'room': '66', 'issue': 'Ehternet'},
    {'name': 'nabeel', 'room': '67', 'issue': 'Router'},
    {'name': 'zain', 'room': '65', 'issue': 'Cable'},
  ];
  List<bool> _isChecked;

  Color _getColor(Set<MaterialState> state){
    Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.focused,
      MaterialState.hovered,
      MaterialState.selected,
    };

    if(state.any(interactiveStates.contains)){
      return Color(0xff1ed760);
    }
  }

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(complaints.length, false);
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
                child: Text(
                  'Complaints',
                  style: kLogoTextStyle.copyWith(color: Color(0xffd3d3d3)),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status', style: kLogoTextStyle),

                  Text('Name', style: kLogoTextStyle),

                  Text('room', style: kLogoTextStyle),

                  Text('issue', style: kLogoTextStyle),

                  
                ],
              ),
              Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.resolveWith<Color>(_getColor),
                              value: _isChecked[index],
                              onChanged: (newValue) =>
                                  setState(() => _isChecked[index] = newValue),
                            ),
                            Text(
                              '${complaints[index]['name']}',
                              style: kLogoTextStyle.copyWith(
                                color: Color(0xffd3d3d3),
                              ),
                            ),
                            Text(
                              '${complaints[index]['room']}',
                              style: kLogoTextStyle.copyWith(
                                color: Color(0xffd3d3d3),
                              ),
                            ),
                            Text(
                              '${complaints[index]['issue']}',
                              style: kLogoTextStyle.copyWith(
                                color: Color(0xffd3d3d3),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
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
