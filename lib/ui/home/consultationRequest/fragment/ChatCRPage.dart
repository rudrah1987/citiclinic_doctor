import 'package:city_clinic_doctor/ui/home/consultationRequest/items/ChatCRItems.dart';
import 'package:flutter/material.dart';

class ChatCRPage extends StatefulWidget {
  @override
  _ChatCRPageState createState() => _ChatCRPageState();
}

class _ChatCRPageState extends State<ChatCRPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ChatCRItems();
        });
  }
}
