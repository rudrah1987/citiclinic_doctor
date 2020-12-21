import 'package:city_clinic_doctor/ui/settings/myConsults/items/PastConsultItems.dart';
import 'package:flutter/material.dart';

class PastConsultPage extends StatefulWidget {
  @override
  _PastConsultPageState createState() => _PastConsultPageState();
}

class _PastConsultPageState extends State<PastConsultPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return PastConsultItems();
        });
  }
}
