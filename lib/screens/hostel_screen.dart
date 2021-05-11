import 'package:complaintronix/components/green_round_button.dart';
import 'package:complaintronix/screens/complaint_screen.dart';
import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';

class HostelScreen extends StatelessWidget {
  static const id = 'hostel_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: kAppbarTitle,
      ),
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  'Select your hostel',
                  style: kLogoTextStyle.copyWith(
                    color: Color(0xffd3d3d3),
                    fontSize: 40.0,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 1,
                          );
                        },
                        buttonText: 'Hostel  1',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 2,
                          );
                        },
                        buttonText: 'Hostel  2',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 3,
                          );
                        },
                        buttonText: 'Hostel  3',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 4,
                          );
                        },
                        buttonText: 'Hostel  4',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 5,
                          );
                        },
                        buttonText: 'Hostel  5',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 6,
                          );
                        },
                        buttonText: 'Hostel  6',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 7,
                          );
                        },
                        buttonText: 'Hostel  7',
                      ),
                      SizedBox(height: 10.0),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 8,
                          );
                        },
                        buttonText: 'Hostel  8',
                      ),
                      SizedBox(height: 10.0),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 9,
                          );
                        },
                        buttonText: 'Hostel  9',
                      ),
                      SizedBox(height: 10.0),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 10,
                          );
                        },
                        buttonText: 'Hostel 10',
                      ),
                      SizedBox(height: 10.0),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 11,
                          );
                        },
                        buttonText: 'Hostel 11',
                      ),
                      SizedBox(height: 10.0),
                      GreenRoundButton(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ComplaintScreen.id,
                            arguments: 12,
                          );
                        },
                        buttonText: 'Hostel 12',
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
