import 'dart:async';
import 'dart:io';

import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';
import 'package:city_clinic_doctor/preference/PreferenceKeys.dart';
import 'package:city_clinic_doctor/ui/home/Dashboard.dart';
import 'package:city_clinic_doctor/ui/splash/Splash2.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_section/utils/application.dart';
import 'modal/auth/user.dart';
import 'new/utils/prefrence_helper.dart';

final navigatorKey = GlobalKey<NavigatorState>();


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    Application().initApp();
  });
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: kPrimaryColor, // navigation bar color
    statusBarColor: kPrimaryColor, // status bar color
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  PreferenceHelper.getUser();

  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(MaterialApp(
      theme: ThemeData(primaryColor: kPrimaryColor, accentColor: kAccentColor),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: SplashMain()
  ));
}

class SplashMain extends StatefulWidget{
  @override
  SplashMainState createState() => SplashMainState();
}

class SplashMainState extends State<SplashMain>{
  @override
  void initState() {
    super.initState();
    getUserFromPreference();
  }

  getUserFromPreference() async{
    print('------getUserFromPreference------');
    // PreferenceHelper.getString('token').then((value) => print('GETTOEN->$value'));
    // print('---------');
    // var k =await PreferenceHelper.getString('token');
    await PreferenceHelper.getUser().then((value){
      // print("userDataSplash -> ${value}");
      //print("userDataSplash -> ${value.accessToken}");
      if(value != null){
        Timer(Duration(seconds: 2), () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Dashboard())));
      }else{
        Timer(Duration(seconds: 2), () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Splash2())));
      }
    }).catchError((error){ print("Error -> $error");
    Timer(Duration(seconds: 2), () =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Splash2())));});
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
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(splash_logo, height:160, width:160,), //   <--- image
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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

}
