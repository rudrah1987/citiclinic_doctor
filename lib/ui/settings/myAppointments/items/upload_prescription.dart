import 'package:city_clinic_doctor/new/constants/string_constants.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../NotificationPage.dart';

class UploadPrescriptionPage extends StatefulWidget {
  @override
  _UploadPrescriptionPageState createState() => _UploadPrescriptionPageState();
}

class _UploadPrescriptionPageState extends State<UploadPrescriptionPage> {
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
          title: Text("Upload Prescription"),
          //Ternery operator use for condition check
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          centerTitle: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => NotificationPage()));
              },
            )
          ]
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Icon(Icons.person,size: 50,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Patient Name: Ram Singh',style: TextStyle(fontFamily: tFontPoppins),),
                      Text('Age: 19',style: TextStyle(fontFamily: tFontPoppins,color: Colors.grey),),
                      Text('Gender: 19',style: TextStyle(fontFamily: tFontPoppins,color: Colors.grey),),
                      Text('Mob No: 19',style: TextStyle(fontFamily: tFontPoppins,color: Colors.grey),),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Container(padding: EdgeInsets.only(left: 10,bottom: 5),child: Text('Medical Details',style: TextStyle(fontFamily: tFontPoppins),)),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                ),
                decoration: const InputDecoration(
                  hintText: 'Type your message....',
                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(16.0),
                    ),
                  ),
                ),
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Message is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Container(padding: EdgeInsets.only(left: 10,bottom: 5),child: Text('Other Details',style: TextStyle(fontFamily: tFontPoppins))),

              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(16.0),
                    ),
                  ),
                ),
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Message is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Container(padding: EdgeInsets.only(left: 10,bottom: 5),child: Text('Upload any pdf or Image file',style: TextStyle(fontFamily: tFontPoppins))),
              Container(
                width: double.infinity,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Icon(Icons.download_rounded),
              ),
              SizedBox(height: 20),
              FlatButton(
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                ),
                color: kPrimaryColor,
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Task is Pending",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                      backgroundColor: kBackgroundColor,
                      textColor: Colors.white);
                },
                height: 50,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
