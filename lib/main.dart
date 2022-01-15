import 'package:complaintronix/screens/status_screen.dart';
import 'package:complaintronix/screens/complaint_screen.dart';
import 'package:complaintronix/screens/complaints_view_screen.dart';
import 'package:complaintronix/screens/hostel_screen.dart';
import 'package:complaintronix/screens/welcome_screen.dart';
import 'package:complaintronix/screens/chat_screen.dart';
import 'package:flutter/material.dart';

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
        ComplaintsViewScreen.id: (context) => ComplaintsViewScreen(
              hostelNumber: ModalRoute.of(context).settings.arguments,
            ),
        // HostelScreen.id: (context) => HostelScreen(),
        ComplaintScreen.id: (context) => ComplaintScreen(
              email: ModalRoute.of(context).settings.arguments,
            ),
        StatusScreen.id: (context) => StatusScreen(
              args: ModalRoute.of(context).settings.arguments,
            ),
        ChatScreen.id: (context) => ChatScreen(
              head: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
