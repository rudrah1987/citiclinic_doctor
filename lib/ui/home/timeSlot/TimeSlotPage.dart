import 'package:city_clinic_doctor/ui/home/timeSlot/fragment/AppointmentTSPage.dart';
import 'package:city_clinic_doctor/ui/home/timeSlot/fragment/ConsultationTSPage.dart';
import 'package:city_clinic_doctor/utils/CircleIndicator.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimeSlotPage extends StatefulWidget {
  @override
  _TimeSlotPageState createState() => _TimeSlotPageState();
}

class _TimeSlotPageState extends State<TimeSlotPage> {
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
            title: Text("Time Slot Management"),
            //Ternery operator use for condition check
            elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
            centerTitle: false,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
//              isScrollable: true,
              indicator: CircleTabIndicator(color: Colors.white, radius: 3),
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: [Tab(text: "Appointments"), Tab(text: "Consultations")],
            ),
          ),
          body: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            children: [AppointmentTSPage(), ConsultationTSPage()],
          ),
        ));
  }
}
