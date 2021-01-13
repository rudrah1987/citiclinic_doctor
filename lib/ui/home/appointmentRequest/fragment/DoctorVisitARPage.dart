import 'package:city_clinic_doctor/modal/apointmentList/apointmentListResponse.dart';
import 'package:city_clinic_doctor/ui/home/appointmentRequest/items/DoctorVisitARItems.dart';
import 'package:flutter/material.dart';

class DoctorVisitARPage extends StatefulWidget {
  final List appointmentData;

  const DoctorVisitARPage({Key key, this.appointmentData}) : super(key: key);
  @override
  _DoctorVisitARPageState createState() => _DoctorVisitARPageState();
}

class _DoctorVisitARPageState extends State<DoctorVisitARPage> {
  @override
  Widget build(BuildContext context) {
    // var _doctorVisitFilter = [];
    // for (var i in widget.appointmentData.data) {
    //   if (i.visitType == '1') {
    //     _doctorVisitFilter.add(i);
    //     print('_doctorVisitFilterAdded--------------$_doctorVisitFilter');
    //   }
    // }
    return widget.appointmentData.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            primary: true,
            itemCount: widget.appointmentData.length,
            itemBuilder: (BuildContext context, int index) {
              return DoctorVisitARItems(data: widget.appointmentData[index]);
            })
        : Center(
            child: Text('No Appointments'),
          );
  }
}
