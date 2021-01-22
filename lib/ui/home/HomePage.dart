import 'package:city_clinic_doctor/new/customs/custom_methods.dart';
import 'package:city_clinic_doctor/ui/home/appointmentRequest/AppointmentRequestPage.dart';
import 'package:city_clinic_doctor/ui/home/consultationRequest/ConsultationRequestPage.dart';
import 'package:city_clinic_doctor/ui/home/timeSlot/TimeSlotPage.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'timeSlot/TimeSlotPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              child: Card(
                  elevation: 3,
                  color: kHomeApointmentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    height: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(appointmentRequestHome, height:40, width:40,),
                          SizedBox(height: 6,),
                          Text("Appointment \nRequest", textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),)
                        ],
                      ),
                    ),
                  )
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AppointmentRequestPage()));
              },
            ),
            SizedBox(height: 6),
            InkWell(
              child: Card(
                  elevation: 3,
                  color: kHomeConsultantColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    height: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(consultantRequestHome, height:60, width:40,),
                          // SizedBox(height: 6,),
                          Text("Consultation  \nRequest", textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),)
                        ],
                      ),
                    ),
                  )
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ConsultationRequestPage()));
              },
            ),
            SizedBox(height: 6),
            InkWell( //Tap Gesture button
              child: Card(
                  elevation: 3,
                  color: kHomeTimeSlotColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    height: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(timeSlotHome, height:40, width:40,),
                          SizedBox(height: 6,),
                          Text("Time Slot \nRequest", textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),)
                        ],
                      ),
                    ),
                  )
              ),
              onTap: (){
                tGotoPush(context, TimeSlotPage());
                // Fluttertoast.showToast(
                //     msg: 'Time Slot should be administrative duty',
                //     toastLength: Toast.LENGTH_SHORT,
                //     gravity: ToastGravity.CENTER,
                //     backgroundColor: Colors.red,
                //     textColor: Colors.white,
                //     fontSize: 16.0
                // );
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TimeSlotPage()));*/
              },
            ),
            /*SizedBox(height: 20,),
            FlatButton(
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              ),
              color: kPrimaryColor,
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Task is Pending",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                    backgroundColor: kBackgroundColor,
                    textColor: Colors.white);
              },
              height: 50,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}


/*Card(
            elevation: 2,
            child: ClipPath(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.green, width: 5))),
              ),
              clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3))),
            ),
          )*/
