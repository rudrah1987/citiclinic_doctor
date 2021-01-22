import 'package:city_clinic_doctor/utils/CircleIndicator.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'TSMtabs/appointment_tsm.dart';
import 'TSMtabs/consultations_tsm.dart';

class TimeSlotManagement extends StatefulWidget {
    static const String routeName = '/timeSlotManagement';

  TimeSlotManagement({Key key}) : super(key: key);

  @override
  _TimeSlotManagementState createState() => _TimeSlotManagementState();
}

class _TimeSlotManagementState extends State<TimeSlotManagement> {
  int _currentIndex=0;
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
            title: Text("Time Slot Managment"),
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
//              isScrollable: true,
              indicator: CircleTabIndicator(color: Colors.white, radius: 3),
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: [Tab(text: "Appointment"), Tab(text: "Consultation")],
            ),
          ),
          body: 
                 TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    AppointmentTSM(),
                    ConsultationTSM()
                  ],
                )
        )
                );
  }
}