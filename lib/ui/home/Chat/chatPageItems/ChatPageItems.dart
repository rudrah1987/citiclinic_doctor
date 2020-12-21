import 'package:city_clinic_doctor/ui/home/Chat/ChatConversationPage.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatPageItems extends StatefulWidget {
  @override
  _ChatPageItemsState createState() => _ChatPageItemsState();
}

class _ChatPageItemsState extends State<ChatPageItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(6),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey[400]),
              borderRadius: BorderRadius.all(Radius.circular(5.0))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(home_account, height:34, width:34),
              SizedBox(width: 16,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Patient Name",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),),
                  SizedBox(height: 2),
                  Text("26 July, 2020",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),),
                ],
              )),
              Text("3:42 pm",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),),
            ],
          ),
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatConversationPage()));
        },
      ),
    );
  }
}
