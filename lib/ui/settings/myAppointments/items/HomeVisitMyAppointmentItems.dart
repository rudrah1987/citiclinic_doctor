import 'package:city_clinic_doctor/modal/apointmentList/apointmentListResponse.dart';
import 'package:city_clinic_doctor/new/customs/custom_methods.dart';
import 'package:city_clinic_doctor/ui/settings/myAppointments/items/upload_prescription.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/Constant.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeVisitMyAppointmentItems extends StatefulWidget {
  final BookingList data;
  HomeVisitMyAppointmentItems(this.data);

  @override
  _HomeVisitMyAppointmentItemsState createState() => _HomeVisitMyAppointmentItemsState();
}

class _HomeVisitMyAppointmentItemsState extends State<HomeVisitMyAppointmentItems> {
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                child: Image.network(
                  "$PROFILE_IMG_TESTING_BASE_PATH${widget.data.patient.profileImage}",
                  errorBuilder: (_, __, ___) {
                    return CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Text(
                        "${widget.data?.patient?.name[0]}",
                      ),
                    );
                  },
                  loadingBuilder: (_, __, ___) {
                    return CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Text(
                        "${widget.data?.patient?.name[0]}",
                      ),
                    );
                  },
                ),
              ),              SizedBox(width: 16,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Patient Name : ${widget.data.patient?.name??''}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),),
                  SizedBox(height: 2),
                  Text("Email id: ${widget.data.patient?.email??''}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  SizedBox(height: 2),
                  Text("Mobile Number: ${widget.data.patient?.phoneNumber??''}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  SizedBox(height: 2),
                  Text("Gender: ${widget.data.patient?.gender??''}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  SizedBox(height: 2),
                  Text("Street Address:${widget.data.patient?.address1??''}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  SizedBox(height: 2),
                  Text("Landmark: ${widget.data.patient?.address2??''}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  SizedBox(height: 2),
                  Text("City: ${widget.data.patient?.cityId??''}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  SizedBox(height: 12),
                  SizedBox(height: 12),
                  Text("APPOINTMENT DETAILS",
                    style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor
                    ),),
                  SizedBox(height: 4),
                  Text("Appointment ID: CCD00${widget.data.bookBy?.id??''}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                  SizedBox(height: 2),
                  Text(
                    "Appointment Date & Time: ${widget.data.otherBookingDeatils?.datetimeStart?.substring(0, 10)??''} ${widget.data.otherBookingDeatils?.datetimeStart?.substring(11, 16)??''}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),

                ],
              ))
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child:  FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: kPrimaryColor)
              ),
              color: Colors.white,
              onPressed: () {
                tGotoPush(context, UploadPrescriptionPage(widget.data.patient));
              },
              height: 42,
              child: Text(
                "Upload Prescription",
                style: TextStyle(color: kPrimaryColor,
                    fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
