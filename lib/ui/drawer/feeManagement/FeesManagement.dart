import 'package:city_clinic_doctor/utils/CircleIndicator.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'fragment/AudioFeesFrag.dart';
import 'fragment/ChatFeesFrag.dart';
import 'fragment/VideoFeesFrag.dart';

class FeesManagement extends StatefulWidget {
  static const String routeName = '/feeManagement';
  @override
  _FeesManagementState createState() => _FeesManagementState();
}

class _FeesManagementState extends State<FeesManagement> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
              ),
            ),
            title: Text("Fees Management"),
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
            bottom: TabBar(
             // isScrollable: true,
              indicator: CircleTabIndicator(color: Colors.white, radius: 3),
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: <Widget>[Tab(text: "Chat"), Tab(text: "Audio"), Tab(text: "Video")],
            ),
          ),
          body: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            children: [ChatFeesFrag(), AudioFeesFrag(), VideoFeesFrag()],
          ),
        ));
  }
}