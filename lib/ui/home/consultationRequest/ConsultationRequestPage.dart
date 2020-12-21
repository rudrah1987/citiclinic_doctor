import 'package:city_clinic_doctor/ui/home/consultationRequest/fragment/AudioCRPage.dart';
import 'package:city_clinic_doctor/ui/home/consultationRequest/fragment/ChatCRPage.dart';
import 'package:city_clinic_doctor/ui/home/consultationRequest/fragment/VideoCRPage.dart';
import 'package:city_clinic_doctor/utils/CircleIndicator.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConsultationRequestPage extends StatefulWidget {
  @override
  _ConsultationRequestPageState createState() => _ConsultationRequestPageState();
}

class _ConsultationRequestPageState extends State<ConsultationRequestPage> {
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
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
            ),
            title: Text("Consultation Request"),
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
              tabs: [Tab(text: "Chat"), Tab(text: "Audio"), Tab(text: "Video")],
            ),
          ),
          body: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            children: [ChatCRPage(), AudioCRPage(), VideoCRPage()],
          ),
        ));
  }
}
