import 'dart:async';

import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';
import 'package:city_clinic_doctor/preference/PreferenceKeys.dart';
import 'package:city_clinic_doctor/ui/splash/Splash2.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessTaskDialog extends StatefulWidget {
  String msg;

  SuccessTaskDialog(this.msg);

  @override
  _SuccessTaskDialogState createState() => _SuccessTaskDialogState();
}

class _SuccessTaskDialogState extends State<SuccessTaskDialog> {

  Timer _timer;
  int _start = 3;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 12,
      backgroundColor: Colors.white,
      child: Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(successSignUp, height:80, width:80,),
              SizedBox(height: 10,),
              Text(
               widget.msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
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
            Navigator.pop(context);
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }
}