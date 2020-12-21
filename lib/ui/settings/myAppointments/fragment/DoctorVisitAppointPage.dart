import 'package:city_clinic_doctor/ui/settings/myAppointments/items/DoctorVisitMyAppointmentItems.dart';
import 'package:flutter/material.dart';

class DoctorVisitAppointPage extends StatefulWidget {
  @override
  _DoctorVisitAppointPageState createState() => _DoctorVisitAppointPageState();
}

class _DoctorVisitAppointPageState extends State<DoctorVisitAppointPage> {

  String _radioValue;
  String choice;

  @override
  void initState() {
    super.initState();

    setState(() {
      _radioValue = "one";
    });
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'one':
          choice = value;
          break;
        case 'two':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Radio(
                        value: 'one',
                        groupValue: _radioValue,
                        onChanged: radioButtonChanges,
                      ),
                      Text(
                        "On Going",
                      )
                    ],
                  )
                )),

             Expanded(child: Row(children: [
               Radio(
                 value: 'two',
                 groupValue: _radioValue,
                 onChanged: radioButtonChanges,
               ),
               Text(
                 "Past",
               )
             ],)),
            ],
          ),
          Expanded(child: ListView.builder(
              scrollDirection: Axis.vertical,
              primary: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return DoctorVisitMyAppointmentItems();
              }))
        ],
      ),
    );
  }
}
