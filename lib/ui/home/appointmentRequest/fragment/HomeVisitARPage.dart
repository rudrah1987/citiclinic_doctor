import 'package:city_clinic_doctor/ui/home/appointmentRequest/items/HomeVisitARItems.dart';
import 'package:flutter/material.dart';

class HomeVisitARPage extends StatefulWidget {
    final List appointmentData;

  const HomeVisitARPage({Key key, this.appointmentData}) : super(key: key);


  @override
  _HomeVisitARPageState createState() => _HomeVisitARPageState();
}

class _HomeVisitARPageState extends State<HomeVisitARPage> {
  @override
  Widget build(BuildContext context) {
    return widget.appointmentData.isNotEmpty? ListView.builder(
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: widget.appointmentData.length,
        itemBuilder: (BuildContext context, int index) {
          return HomeVisitARItems(data:widget.appointmentData[index]);
        }):Center(child: Text("No appointments"));
  }
}
