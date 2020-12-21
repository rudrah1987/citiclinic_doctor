import 'package:city_clinic_doctor/ui/drawer/prescriptionManagement/PrescriptionItems.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  static const String routeName = '/prescriptionManagement';
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          primary: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return PrescriptionItems();
          }),
    );
  }
}
