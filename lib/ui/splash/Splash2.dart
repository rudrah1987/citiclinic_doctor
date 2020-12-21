import 'dart:io';

import 'package:city_clinic_doctor/ui/auth/Login.dart';
import 'package:city_clinic_doctor/ui/auth/SignUp.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';

class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:  Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: kBackgroundColor),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(splash_logo, height:100, width:100,), //   <--- image
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
//                            margin: EdgeInsets.only(top: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Welcome to", textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 36,
                                fontFamily: 'Poppins',
                                color: Colors.white),
                          ),
                          Text("City Clinic", textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.white)),
                            color: Colors.white,
                            minWidth: 200,
                            height: 40,
                            textColor: kBackgroundColor,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Login()));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp()));
                            },
                            minWidth: 200,
                            height: 40,
                            color: kBackgroundColor,
                            textColor: Colors.white,
                            child: Text("Sign Up",
                                style: TextStyle(fontSize: 16)),
                          ),
                          SizedBox(height: 50),
                          Text("cityclinickwt.com".toUpperCase(), textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: kSplashTextColor),
                          )

                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print("Latitude -> ${_currentPosition.latitude} :: Longitude -> ${_currentPosition.longitude}");
        CCDoctorPrefs.saveCurrentLocationLatitude(_currentPosition.latitude);
        CCDoctorPrefs.saveCurrentLocationLongitude(_currentPosition.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }
}