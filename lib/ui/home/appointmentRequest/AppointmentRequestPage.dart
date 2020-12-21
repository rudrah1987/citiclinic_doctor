import 'package:city_clinic_doctor/ui/home/appointmentRequest/fragment/DoctorVisitARPage.dart';
import 'package:city_clinic_doctor/ui/home/appointmentRequest/fragment/HomeVisitARPage.dart';
import 'package:city_clinic_doctor/utils/CircleIndicator.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppointmentRequestPage extends StatefulWidget {
  @override
  _AppointmentRequestPageState createState() => _AppointmentRequestPageState();
}

class _AppointmentRequestPageState extends State<AppointmentRequestPage> {
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
            title: Text("Appointment Request"),
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
              tabs: [Tab(text: "Doctor Visit"), Tab(text: "Home Visit")],
            ),
          ),
          body: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            children: [DoctorVisitARPage(), HomeVisitARPage()],
          ),
        ));
  }
}
