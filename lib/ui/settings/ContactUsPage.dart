import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'NotificationPage.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
          title: Text("Contact Us"),
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
            color: Colors.white,
            // height: double.maxFinite,
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Positioned(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400
                      ),
                      decoration: const InputDecoration(
                        hintText: '-Enter full name-',
                        labelText: 'Full Name',
                      ),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Full Name is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400
                      ),
                      decoration: const InputDecoration(
                        hintText: '-Enter mobile number-',
                        labelText: 'Mobile Number',
                      ),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Mobile Number is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400
                      ),
                      decoration: const InputDecoration(
                        hintText: '-Enter email id-',
                        labelText: 'Email Id',
                      ),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Email id is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child:  Text("Message", textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 5,),
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
                    SizedBox(height: 55),
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
                ))
              ],
            )
        ),
      )
    );
  }
}
