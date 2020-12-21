import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeVisitARItems extends StatefulWidget {
  @override
  _HomeVisitARItemsState createState() => _HomeVisitARItemsState();
}

class _HomeVisitARItemsState extends State<HomeVisitARItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(6),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey[400]),
          borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(profile_placeholder, height:42, width:42),
          SizedBox(width: 16,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Patient Name : John Doe",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87
                ),),
              SizedBox(height: 2),
              Text("Email id: johndoe@email.com",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("Mobile Number: 98765 43210",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("Gender: Male",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("Street Address: 1, Road No.10,Delhi-110001",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("Landmark: Near Domino’s",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("City: New Delhi",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 12),
              Text("APPOINTMENT DETAILS",
                style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    color: kPrimaryColor
                ),),
              SizedBox(height: 4),
              Text("Appointment ID: CD1379",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("Appointment Date & Time: 06/09/2020 07:58:00 PM",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
            ],
          ))
        ],
      ),
    );
  }
}
