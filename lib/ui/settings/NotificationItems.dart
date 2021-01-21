import 'package:city_clinic_doctor/modal/notifications/notifications_response.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:city_clinic_doctor/new/exten/extenstins.dart';

class NotificationItems extends StatefulWidget {
  final Data data;
  final Function onDelete;
  NotificationItems(this.data, this.onDelete);

  @override
  _NotificationItemsState createState() => _NotificationItemsState();
}

class _NotificationItemsState extends State<NotificationItems> {
  bool isDeleting;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey[400]),
          borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 20,),
              SvgPicture.asset(notificationBellImage, height:35, width:24),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data?.title??'',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87
                ),),
              SizedBox(height: 5),
              Text(widget.data?.description??'',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
              // ignore: unrelated_type_equality_checks
              Text(DateTime.parse(widget.data.updatedAt).day==DateTime.now().day?'Today':DateTime.parse(widget.data.updatedAt).beautify(),
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
            ],
          )),
          IconButton(icon: Icon(Icons.delete_outline), onPressed: ()=>widget.onDelete(widget.data.id))
        ],
      ),
    );
  }
}
