import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:complaintronix/utilities/constants.dart';
// import 'package:complaintronix/services/messages.dart';
import 'package:complaintronix/components/message_bubble.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({this.head});
  static const String id = 'chat_screen';

  final bool head;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  String messageText;

  StreamSocket messagesStream;

  @override
  void initState() {
    messagesStream = StreamSocket();
    super.initState();
  }

  @override
  void dispose() {
    messagesStream.dispose();
    super.dispose();
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
            // MessagesStream(
            //     // loggedInUser: loggedInUser,
            //     ),

            StreamBuilder<dynamic>(
              stream: messagesStream.stream,
              // initialData: 'Welcome to chat!',
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
                final messages = snapshot.data; //= snapshot.data.docs.reversed;
                for (var message in messages) {
                  final messageText = message['text'];
                  final messageSender = message['sender'];

                  // final currentUser = loggedInUser.email;

                  final messageBubble = MessageBubble(
                    sender: messageSender.toString(),
                    text: messageText,
                    isMe: false,
                    // isMe: currentUser ==
                    //     messageSender, //The message from the logged in user
                  );
                  messageBubbles.add(messageBubble);
                }
                // print(snapshot.data.toString());
                // return Container();

                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                );
              },
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
                      messagesStream.sendMessage(
                        messageText: messageText,
                      );
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

class StreamSocket {
  StreamSocket() {
    connectAndListen();
  }

  final _socketResponse = StreamController<dynamic>();

  void addMessages(List messages) => _socketResponse.sink.add(messages);

  Stream<dynamic> get stream => _socketResponse.stream;

  void dispose() {
    socket.close();
    _socketResponse.close();
  }

  Socket socket = io(
      'https://complaintronix.herokuapp.com/messageSocket',
      // 'http://127.0.0.1:5000/messageSocket',
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  void connectAndListen() {
    socket.connect();

    socket.onConnect((_) {
      print('connected : ' + socket.id);
      // socket.emit('message', 'connected from flutter ${socket.id}');
    });

    socket.on("message", (data) {
      // print(jsonDecode(data)[0]);
      List messages = [];

      for (var message in jsonDecode(data)) {
        // messages.add(jsonDecode(message));
        // json
        // print(jsonDecode(message.toString()));
        // print(message['msg_text']);
        messages.add({
          'text': message['msg_text'],
          'sender': message['msgr_reg'],
          'time': message['messaged_at']
        });
      }
      addMessages(messages.reversed.toList());
    });

    socket.onDisconnect((_) => print('disconnect'));
  }

  void sendMessage({String messageText}) {
    socket.emit('message', {
      'text': messageText,
      'sender': 2018460,
    });
    // addMessages(messageText);
  }
}
