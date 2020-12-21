import 'package:city_clinic_doctor/modal/consultationRequest/videoCRModel.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoCRItems extends StatelessWidget {

  VideoCRModel videoCRModel;
  VideoCRItems(this.videoCRModel);

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
              Text("Patient Name : ${videoCRModel.patientName}",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87
                ),),
              SizedBox(height: 2),
              Text("Email id: ${videoCRModel.emailID}",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("Mobile Number: ${videoCRModel.mobNumber}",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("Gender: ${videoCRModel.gender}",
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
              Text("Consultation ID: ${videoCRModel.consulationID}",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),


              SizedBox(height: 16),
              Center(
                child: Text("Show details",
                  style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w400
                  ),),
              )
            ],
          )),
          SvgPicture.asset(videoCRImage, height:32, width:32),
        ],
      ),
    );
  }
}

