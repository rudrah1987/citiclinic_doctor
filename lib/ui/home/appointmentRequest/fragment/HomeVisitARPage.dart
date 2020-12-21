import 'package:city_clinic_doctor/ui/home/appointmentRequest/items/HomeVisitARItems.dart';
import 'package:flutter/material.dart';

class HomeVisitARPage extends StatefulWidget {
  @override
  _HomeVisitARPageState createState() => _HomeVisitARPageState();
}

class _HomeVisitARPageState extends State<HomeVisitARPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return HomeVisitARItems();
        });
  }
}
