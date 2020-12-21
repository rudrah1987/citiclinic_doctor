import 'package:city_clinic_doctor/ui/settings/myConsults/fragment/OnGoingConsultPage.dart';
import 'package:city_clinic_doctor/ui/settings/myConsults/fragment/PastConsultPage.dart';
import 'package:city_clinic_doctor/utils/CircleIndicator.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../NotificationPage.dart';

class MyConsultsPage extends StatefulWidget {
  @override
  _MyConsultsPageState createState() => _MyConsultsPageState();
}

class _MyConsultsPageState extends State<MyConsultsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
            ),
            title: Text("My Consults"),
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
            ],
          bottom: TabBar(
//              isScrollable: true,
            indicator: CircleTabIndicator(color: Colors.white, radius: 3),
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: [Tab(text: "On Going"), Tab(text: "Past")],
          ),
        ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [OnGoingConsultPage(), PastConsultPage()],
          ),
    ));
  }
}
