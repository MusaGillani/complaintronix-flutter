// import 'package:flutter/material.dart';


// class MessagesStream extends StatefulWidget {

//   @override
//   State<MessagesStream> createState() => _MessagesStreamState();
// }

// class _MessagesStreamState extends State<MessagesStream> {
  

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<String>(
//       stream: messagesStream.stream,
//       builder: (context, snapshot) {
//         List<MessageBubble> messageBubbles = [];
//         if (!snapshot.hasData) {
//           // showing spinner until we get data
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.lightBlueAccent,
//             ),
//           );
//         }
//         // final messages  = ;//= snapshot.data.docs.reversed;
//         // for (var message in messages) {
//         //   final messageText = message['text'];
//         //   final messageSender = message['sender'];

//         //   final currentUser = loggedInUser.email;

//         // final messageBubble = MessageBubble(
//         //   sender: 'messageSender',
//         //   text: messageText,
//         //   isMe: false,
//         //   // isMe: currentUser ==
//         //   //     messageSender, //The message from the logged in user
//         // );
//         // messageBubbles.add(messageBubble);
//         // }
//         print(snapshot.data.toString());
//         return Container();

//         // return Expanded(
//         //   child: ListView(
//         //       reverse: true,
//         //       padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//         //       children: messageBubbles),
//         // );
//       },
//     );
//   }
// }
