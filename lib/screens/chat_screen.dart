import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:complaintronix/utilities/constants.dart';
import 'package:complaintronix/services/messages.dart';

User loggedInUser;

class ChatScreen extends StatefulWidget {
  ChatScreen({this.head});
  static const String id = 'chat_screen';

  final bool head;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: kAppbarTitle,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessagesStream(
              loggedInUser: loggedInUser,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (newValue) {
                        // save messageText here
                        messageText = newValue;
                      },
                      decoration: kMessageFiekdDecoration,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // send message text
                      messageTextController.clear();
                      sendMessage(messageText: messageText,loggedInUser: loggedInUser);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
