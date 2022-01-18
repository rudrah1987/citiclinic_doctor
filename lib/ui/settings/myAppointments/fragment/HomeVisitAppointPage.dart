import 'package:city_clinic_doctor/ui/settings/myAppointments/items/HomeVisitMyAppointmentItems.dart';
import 'package:flutter/material.dart';


import 'package:city_clinic_doctor/chat_section/utils/consts.dart';
import 'package:city_clinic_doctor/modal/apointmentList/apointmentListResponse.dart';
import 'package:city_clinic_doctor/ui/auth/bloc/LoginBloc.dart';
import 'package:city_clinic_doctor/ui/settings/myAppointments/bloc/apointmentBloc.dart';
import 'package:city_clinic_doctor/ui/settings/myAppointments/items/DoctorVisitMyAppointmentItems.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/material.dart';

class HomeVisitAppointPage extends StatefulWidget {
  @override
  _HomeVisitAppointPageState createState() => _HomeVisitAppointPageState();
}

class _HomeVisitAppointPageState extends State<HomeVisitAppointPage> {
  String _radioValue;
  String choice;

  MyAppointmentBloc _myAppointmentBloc = MyAppointmentBloc();

  var onGoingHomeVisitList = [];
  var pastHomeVisitList = [];
  // var onGoingHomeVisiList = [];

  @override
  void initState() {
    super.initState();
    // _myAppointmentBloc.getPastAppointments(currentUser.value.user.userId);
    _myAppointmentBloc.getOnGoingAppointments(currentUser.value.user.userId);

    _myAppointmentBloc.pastAppointmentStream.listen((event) {
      print("getting data ${event.data}");
    });

    _myAppointmentBloc.onGoingAppointmentStream.listen((event) {
      print("Listing ONGOING ${event.data}");
      for (var i in event.data.bookingList) {
        if (i.otherBookingDeatils.visitType != '1') {
          setState(() {
            onGoingHomeVisitList.add(i);
          });
        }
      }
      print('DOCVISIT ONGOING--$onGoingHomeVisitList');
    });
    // _myAppointmentBloc.pastAppointmentStream.listen((event) {
    //   print("Listing PAST ${event.data}");
    //   for (var i in event.data.bookingList) {
    //     if (i.otherBookingDeatils.visitType == '1') {
    //       print('PAST VISIT TYPE--${i.otherBookingDeatils.visitType}');
    //       setState(() {
    //         pastDocVisitList.add(i);
    //       });
    //     }
    //   }
    //   print('DOCVISIT PAST--$pastDocVisitList');
    // });
    setState(() {
      _radioValue = "one";
      choice = 'one';
    });
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'one':
          choice = value;
          // _myAppointmentBloc.getOnGoingAppointments(currentUser.value.user.userId);


          break;
        case 'two':
          choice = value;
          pastHomeVisitList.clear();
          _myAppointmentBloc.getPastAppointments(currentUser.value.user.userId);
          // _myAppointmentBloc.pastAppointmentStream.
          _myAppointmentBloc.pastAppointmentStream.listen((event) {
            print("Listing PAST ${event.data}");
            for (var i in event.data.bookingList) {
              if (i.otherBookingDeatils.visitType != '1') {
                print('PAST VISIT TYPE--${i.otherBookingDeatils.visitType}');
                setState(() {
                  pastHomeVisitList.add(i);
                });
              }
            }
            print('HomeVISIT PAST--${pastHomeVisitList.toSet().toList()}');
          });

          break;
        default:
          choice = null;
      }
      print('Print--------------${choice}'); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    child: Row(
                      children: [
                        Radio(
                          activeColor: kPrimaryColor,
                          value: 'one',
                          groupValue: _radioValue,
                          onChanged: radioButtonChanges,
                        ),
                        Text(
                          "On Going",
                        )
                      ],
                    )),
                Row(
                  children: [
                    Radio(
                      activeColor: kPrimaryColor,
                      value: 'two',
                      groupValue: _radioValue,
                      onChanged: radioButtonChanges,
                    ),
                    Text(
                      "Past",
                    )
                  ],
                ),
              ],
            ),
            choice == 'one'
                ? onGoingHomeVisitList!=null
                ? onGoingHomeVisitList.isNotEmpty?ListView.builder(
              // scrollDirection: Axis.vertical,
                primary: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: onGoingHomeVisitList.toSet().toList().length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  print('FOR CHOICE ONGOING');
                  // print('VISIT TYPE----${onGoingDocVisitList[i].otherBookingDeatils.visitType}');
                  return DoctorVisitMyAppointmentItems(
                      onGoingHomeVisitList.toSet().toList()[i]);
                }):Center(child: Text('No Appointments'))
                : CircularProgressIndicator(
              valueColor:
              new AlwaysStoppedAnimation<Color>(kPrimaryColor),
            )
                :

            pastHomeVisitList!=null
                ? pastHomeVisitList.isNotEmpty?ListView.builder(
              // scrollDirection: Axis.vertical,
                primary: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: pastHomeVisitList.toSet().toList().length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  print('FOR CHOICE PAST');
                  print(
                      'VISIT TYPE----${pastHomeVisitList.toSet().toList()[i].otherBookingDeatils.visitType}');
                  return HomeVisitMyAppointmentItems(
                      pastHomeVisitList.toSet().toList()[i]);
                }):Center(child: Text('No Appointments'))
                : CircularProgressIndicator(
              valueColor:
              new AlwaysStoppedAnimation<Color>(kPrimaryColor),
            )
            // : Text('No Data');
          ],
        ),
      ),
    );
  }
}

