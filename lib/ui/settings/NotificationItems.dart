import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationItems extends StatefulWidget {
  @override
  _NotificationItemsState createState() => _NotificationItemsState();
}

class _NotificationItemsState extends State<NotificationItems> {
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
          SvgPicture.asset(notificationBellImage, height:24, width:24),
          SizedBox(width: 16,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("New Appointment ( Home Visit )",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87
                ),),
              SizedBox(height: 5),
              Text("Hey Doctor, You have new home visit appointment by Patient. John Doe.",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              SizedBox(height: 10),
              Text("Today, 1:01 PM",
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
