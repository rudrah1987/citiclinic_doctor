import 'package:city_clinic_doctor/modal/staticResponse/staticResponse.dart';
import 'package:city_clinic_doctor/utils/String.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'NotificationPage.dart';

class PrivacyPolicy extends StatelessWidget {
  final Data data;
  PrivacyPolicy(this.data);

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
          title: Text("Privacy Policy"),
          //Ternery operator use for condition check
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NotificationPage()));
              },
            )
          ]),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.description,
              style: TextStyle(
                  color: kAuthTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
           
          ],
        ),
      ),
    );
  }
}
