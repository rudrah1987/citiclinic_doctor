import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrescriptionItems extends StatefulWidget {
  @override
  _PrescriptionItemsState createState() => _PrescriptionItemsState();
}

class _PrescriptionItemsState extends State<PrescriptionItems> {
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
          SizedBox(width: 12,),
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
              SizedBox(height: 15),
              Text("Medicine Name",
                style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    color: kPrimaryColor
                ),),
              SizedBox(height: 4),
              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dignissim dignissim.",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 15),
              Text("Other Details",
                style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    color: kPrimaryColor
                ),),
              SizedBox(height: 4),
              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dignissim dignissim.",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("PRESCRIPTION GIVEN ON 09-07-20",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      color: kPrimaryColor
                  ),),
              )
            ],
          ))
        ],
      ),
    );
  }
}
