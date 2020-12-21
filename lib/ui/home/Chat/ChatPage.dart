import 'package:flutter/material.dart';
import 'chatPageItems/ChatPageItems.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/myChat';
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            primary: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return ChatPageItems();
            }),
      ),
    );
  }
}