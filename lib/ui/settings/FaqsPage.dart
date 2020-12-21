import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'NotificationPage.dart';

class FaqsPage extends StatelessWidget {
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
          title: Text("FAQs"),
          //Ternery operator use for condition check
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          centerTitle: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => NotificationPage()));
              },
            )
          ]
      ),
      body: Container(
        child: Center(
          child: Text("Faq's Webview"),
        ),
      ),
    );
  }
}
