import 'package:city_clinic_doctor/ui/home/appointmentRequest/items/DoctorVisitARItems.dart';
import 'package:flutter/material.dart';

class DoctorVisitARPage extends StatefulWidget {
  @override
  _DoctorVisitARPageState createState() => _DoctorVisitARPageState();
}

class _DoctorVisitARPageState extends State<DoctorVisitARPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return DoctorVisitARItems();
        });
  }
}
