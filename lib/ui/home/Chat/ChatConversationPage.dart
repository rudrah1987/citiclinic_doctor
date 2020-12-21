import 'package:city_clinic_doctor/ui/home/Chat/widgets/ChatItemWidget.dart';
import 'package:city_clinic_doctor/ui/home/Chat/widgets/InputChatWidget.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatConversationPage extends StatefulWidget {
  @override
  _ChatConversationPageState createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {

  final ScrollController listScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(14),
          ),
        ),
        title: Text("Patient Name"),
        //Ternery operator use for condition check
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        centerTitle: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          color: Colors.white,
          // height: double.maxFinite,
          padding: EdgeInsets.all(16),
          child: Stack(
            children: [
              Positioned(child: Container(
                height: 460,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => ChatItemWidget(index),
                    itemCount: 8,
                    reverse: true,
                    controller: listScrollController,
                  ))),
              Positioned(child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: InputChatWidget(),
              ))
            ],
          )
      ),
    );
  }
}
