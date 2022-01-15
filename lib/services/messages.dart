import 'package:flutter/material.dart';
import 'package:complaintronix/components/message_bubble.dart';

void sendMessage({String messageText, dynamic loggedInUser}) {
  // _firestore.collection('messages').add(
  //   {
  //     'text': messageText,
  //     'sender': loggedInUser.email,
  //     'ts': FieldValue.serverTimestamp(),
  //   },
  // );
}

class MessagesStream extends StatelessWidget {
  MessagesStream({@required this.loggedInUser});

  final dynamic loggedInUser;

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<QuerySnapshot>(
    // stream: _firestore.collection('messages').orderBy('ts').snapshots(),
    return StreamBuilder<String>(
      // stream: _firestore.collection('messages').orderBy('ts').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          // showing spinner until we get data
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        // final messages  = ;//= snapshot.data.docs.reversed;
        // for (var message in messages) {
        //   final messageText = message['text'];
        //   final messageSender = message['sender'];

        //   final currentUser = loggedInUser.email;

        //   final messageBubble = MessageBubble(
        //     sender: messageSender,
        //     text: messageText,
        //     isMe: currentUser ==
        //         messageSender, //The message from the logged in user
        //   );
        //   messageBubbles.add(messageBubble);
        // }

        return Expanded(
          child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles),
        );
      },
    );
  }
}
