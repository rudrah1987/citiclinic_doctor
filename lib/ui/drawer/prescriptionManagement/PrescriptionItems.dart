import 'package:city_clinic_doctor/modal/prescriptions/prescriptions.dart';
import 'package:city_clinic_doctor/network/api_provider.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/Constant.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:city_clinic_doctor/new/exten/extenstins.dart';

class PrescriptionItems extends StatefulWidget {
  final PrescriptionList prescriptionList;
  PrescriptionItems(this.prescriptionList);


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
          ClipRRect(
            child: Image.network(
              "$PROFILE_IMG_TESTING_BASE_PATH${widget.prescriptionList.patient.profileImage}",
              errorBuilder: (_, __, ___) {
                return CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Text(
                    "${widget.prescriptionList?.patient?.name[0]}",
                  ),
                );
              },
              loadingBuilder: (_, __, ___) {
                return CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Text(
                    "${widget.prescriptionList?.patient?.name[0]}",
                  ),
                );
              },
            ),
          ),          SizedBox(width: 12,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Patient Name : ${widget.prescriptionList.patient?.name??''}",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87
                ),),
              SizedBox(height: 2),
              Text("Email id: ${widget.prescriptionList.patient?.email??''}",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 2),
              Text("Mobile Number: ${widget.prescriptionList.patient?.phoneNumber??''}",
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
              Text("${widget.prescriptionList.otherPrescriptionDeatils?.medicines??''}",
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
              Text("${widget.prescriptionList.otherPrescriptionDeatils?.message??''}",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("PRESCRIPTION GIVEN ON ${DateTime.parse(widget.prescriptionList.otherPrescriptionDeatils.created).beautify()}",
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
