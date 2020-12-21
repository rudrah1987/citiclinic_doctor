import 'package:city_clinic_doctor/modal/consultationRequest/videoCRModel.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:city_clinic_doctor/utils/RichTextWidget.dart';

class ConsultDetailAcToType extends StatelessWidget {

  VideoCRModel videoCRModel;
  ConsultDetailAcToType(this.videoCRModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(14),
            ),
          ),
          title: Text("Consultation Type : ${videoCRModel.consultType}", style: TextStyle(
              fontSize: 15
          ),),
          //Ternery operator use for condition check
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          centerTitle: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(6),
        width: double.infinity,
        child: Column(
          children: [
            Text("9AM to 9:15AM on Thu, July 09",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  color: Colors.black
              ),),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Container(
                  padding: EdgeInsets.all(6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Consultation ID",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                          ),),
                        SizedBox(height: 4),
                        Text(videoCRModel.consulationID,
                          style: TextStyle(
                              fontSize: 12,
                              color: kPrimaryColor
                          ),),
                      ],
                    ),
                  ),
                )),
                Expanded(child: Container(
                  padding: EdgeInsets.all(6),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Consultation for",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                          ),),
                        SizedBox(height: 4),
                        Text("Self",
                          style: TextStyle(
                              fontSize: 12,
                              color: kPrimaryColor
                          ),),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.all(6),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[400]),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                        ],
                      )),
                      SvgPicture.asset(videoCRImage, height:32, width:32),
                    ],
                  ),

                  SizedBox(height: 8),
                  Divider(thickness: 2, color: kPrimaryColor,),
                  SizedBox(height: 8),
                  Center(
                    child:   Text("Basic Informations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: kPrimaryColor
                      ),),
                  ),
                  SizedBox(height: 15),
                  RichTextWidget("Name : ", videoCRModel.patientName),
                  SizedBox(height: 4),
                  RichTextWidget("Relation : ", "Son"),
                  SizedBox(height: 4),
                  RichTextWidget("Date of Birth : ", "July 09 1996"),
                  SizedBox(height: 4),
                  RichTextWidget("Height : ", "176.78cms"),
                  SizedBox(height: 4),
                  RichTextWidget("Weight : ", "63Kg"),
                  SizedBox(height: 4),
                  RichTextWidget("Blood Group : ", "A+"),
                  SizedBox(height: 4),
                  RichTextWidget("Street Address : ", "141, 2nd Floor, New Delhi 110040"),
                  SizedBox(height: 4),
                  RichTextWidget("Locality : ", "Rohini Sector 15"),
                  SizedBox(height: 4),
                  RichTextWidget("City : ", "New Delhi"),
                  SizedBox(height: 4),
                  RichTextWidget("Country : ", "India"),
                  SizedBox(height: 12),
                  Divider(thickness: 2, color: Colors.grey,),
                  SizedBox(height: 8),
                  Center(
                    child: Text("Package Details",
                      style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: kPrimaryColor
                      ),),
                  ),
                  SizedBox(height: 10),
                  RichTextWidget("Purchased on Date : ", "July 8, 2020"),
                  SizedBox(height: 4),
                  Text("7 days validity",
                    style: TextStyle(
                        fontSize: 12,
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline
                    ),),
                  SizedBox(height: 4),
                  Text(r"$30 Consultation Fee",
                    style: TextStyle(
                        fontSize: 12,
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline
                    ),),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}