import 'package:city_clinic_doctor/ui/settings/myConsults/items/OnGoingConsultItems.dart';
import 'package:flutter/material.dart';

class OnGoingConsultPage extends StatefulWidget {
  @override
  _OnGoingConsultPageState createState() => _OnGoingConsultPageState();
}

class _OnGoingConsultPageState extends State<OnGoingConsultPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return OnGoingConsultItems();
        });
  }
}
