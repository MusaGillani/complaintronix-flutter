import 'package:complaintronix/screens/complaint_screen.dart';
import 'package:complaintronix/screens/complaints_view_screen.dart';
import 'package:complaintronix/screens/hostel_screen.dart';
import 'package:complaintronix/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        accentColor: Color(0xff1ed760),
      ),
      title: 'Complaintronix',
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegisterScreen.id : (context) => RegisterScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        ComplaintsView.id : (context) =>ComplaintsView(),
        HostelScreen.id : (context) => HostelScreen(),
        ComplaintScreen.id: (context) => ComplaintScreen(hostelNumber : ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
