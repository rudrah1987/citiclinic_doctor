import 'package:city_clinic_doctor/ui/settings/NotificationPage.dart';
import 'package:city_clinic_doctor/utils/String.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TermConditionPage extends StatelessWidget {
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
        title: Text("Terms & Conditions"),
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
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(privacy_policy1,
              style: TextStyle(
                  color: kAuthTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            SizedBox(height: 16,),
            Text(privacy_policy2,
              style: TextStyle(
                  color: kAuthTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            SizedBox(height: 16,),
            Text(privacy_policy3,
              style: TextStyle(
                  color: kAuthTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            SizedBox(height: 16,),
            Text(privacy_policy4,
              style: TextStyle(
                  color: kAuthTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
            SizedBox(height: 16,),
            Text(privacy_policy5,
              style: TextStyle(
                  color: kAuthTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
          ],
        ),
      ),
    );
  }
}
