import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PastConsultItems extends StatefulWidget {
  @override
  _PastConsultItemsState createState() => _PastConsultItemsState();
}

class _PastConsultItemsState extends State<PastConsultItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      margin: EdgeInsets.all(6),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey[400]),
          borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Expanded(child: Text("Consult ID : 112307",
                style: TextStyle(
                    fontSize: 14,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700
                ),),),
              SvgPicture.asset(audioCRImage, height:24, width:24),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                child: Stack(
                  children: [
                    Positioned(
                      child: Center(
                        child: SvgPicture.asset(consultUserImage, height:42, width:42),
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: FractionalOffset.bottomLeft,
                        child: SvgPicture.asset(pastCancelConsultImage, height:24, width:24),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                // flex: 1,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Patient Name",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87
                        ),),
                      SizedBox(height: 2),
                      Text("Today",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                        ),),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child:  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(consultTimeImage, height:14, width:14),
                          SizedBox(width: 8,),
                          Expanded(
                            child: Text("9 July 2020, 10:00 AM - 11:15 AM",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black87
                              ),),
                          )
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          SvgPicture.asset(consultAudioImage, height:14, width:14),
                          SizedBox(width: 8,),
                          Text("Audio Consult",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black87
                            ),),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
