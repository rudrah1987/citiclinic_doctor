import 'dart:async';

import 'package:city_clinic_doctor/ui/home/Dashboard.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessSignUpPage extends StatefulWidget {
  @override
  _SuccessSignUpPageState createState() => _SuccessSignUpPageState();
}

class _SuccessSignUpPageState extends State<SuccessSignUpPage> {

  Timer _timer;
  int _start = 3;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(successSignUp, height:120, width:120,),
                SizedBox(height: 10,),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "Success",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    "Thank you for choosing City Clinic",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: kAuthTextGreyColor),
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                Dashboard()), (Route<dynamic> route) => false);
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }
}